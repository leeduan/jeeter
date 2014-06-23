class Upload < ActiveRecord::Base
  belongs_to :user
  has_attached_file :media

  before_create :sluggify_file_name

  validates :media, attachment_presence: true
  validates_presence_of :user_id
  validates_attachment_content_type :media, content_type: [
    /\Aimage\/.*\Z/, /\Avideo\/.*\Z/, /\Aaudio\/.*\Z/, /\Aapplication\/.*\Z/
  ]

  def sluggify_file_name
    extension = File.extname(media_file_name).gsub(/^\.+/, '')
    filename = media_file_name.gsub(/\.#{extension}$/, '')
    new_filename = increment_filename({ filename: to_slug(filename), extension: extension.downcase })
    self.media.instance_write(:file_name, new_filename)
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