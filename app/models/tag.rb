class Tag < ActiveRecord::Base
  default_scope { order('name ASC') }
  NAME_MIN_LENGTH = 2

  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true, length: { minimum: NAME_MIN_LENGTH }

  def self.handleInput(text)
    tags = text.split(',').map do |tag|
      name = tag.strip
      if name.length >= NAME_MIN_LENGTH
        tag_object = Tag.find_by name: name
        tag_object.nil? ? Tag.create(name: name) : tag_object
      end
    end
    tags.compact
  end
end