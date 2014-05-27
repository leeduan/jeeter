class Tag < ActiveRecord::Base
  default_scope { order('name ASC') }

  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true

  def self.createByInput(text)
    tag = text.split(',').map do |tag|
      tag_name = tag.strip
      Tag.find_or_create_by(name: tag_name) if tag_name.length > 0
    end
    tag.uniq.compact
  end
end