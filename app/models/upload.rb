class Upload < ActiveRecord::Base
  include Searchable
  default_scope { order('created_at DESC') }

  belongs_to :user
  has_attached_file :media
  paginates_per 10

  before_create :sluggify_file_name, :extract_dimensions
  serialize :dimensions

  validates :media, attachment_presence: true
  validates_length_of :alt, maximum: 255
  validates_presence_of :user_id
  validates_attachment_content_type :media, content_type: [
    /^image\/.*$/, /^video\/.*$/, /^audio\/.*$/, /^application\/.*$/
  ]

  def sluggify_file_name
    extension = File.extname(media_file_name).gsub(/^\.+/, '')
    filename = media_file_name.gsub(/\.#{extension}$/, '')
    new_filename = increment_filename({ filename: to_slug(filename), extension: extension.downcase })
    self.media.instance_write(:file_name, new_filename)
  end

  def basename
    File.basename(media_file_name, extension)
  end

  def extension
    File.extname media_file_name
  end

  def extract_dimensions
    return unless image?
    tempfile = media.queued_for_write[:original]
    unless tempfile.nil?
      geometry = Paperclip::Geometry.from_file(tempfile)
      self.dimensions = [geometry.width.to_i, geometry.height.to_i]
    end
  end

  def file_type
    if media_content_type =~ /^image\/.*$/
      return 'image'
    elsif media_content_type =~ /^video\/.*$/
      return 'video'
    elsif media_content_type =~ /^audio\/.*$/
      return 'audio'
    else
      return 'file'
    end
  end

  def image?
    file_type == 'image'
  end

  private

  def to_slug(filename)
    filename.strip!
    filename.gsub! /\s*[^a-zA-Z0-9]\s*/, '-'
    filename.gsub! /-+/, '-'
    filename.downcase
  end

  def increment_filename(options)
    incrementor = 1
    new_filename = "#{options[:filename]}.#{options[:extension]}"
    file_path = file_upload_path(new_filename)

    while FileTest.exist?(file_path)
      new_filename = "#{options[:filename]}-#{incrementor}.#{options[:extension]}"
      file_path = file_upload_path(new_filename)
      incrementor += 1
    end
    new_filename
  end

  def file_upload_path(new_filename)
    Paperclip::Attachment.default_options[:path].sub(':filename', new_filename)
  end
end