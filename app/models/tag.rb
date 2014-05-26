class Tag < ActiveRecord::Base
  default_scope { order('name ASC') }
  NAME_MIN_LENGTH = 2

  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true, length: { minimum: NAME_MIN_LENGTH }

  def self.createByInput(text)
    tags = text.split(',').map do |tag|
      tag_name = tag.strip
      Tag.find_or_create_by(name: tag_name) if tag_name.length >= NAME_MIN_LENGTH
    end
    tags.compact
  end
end