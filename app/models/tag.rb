class Tag < ActiveRecord::Base
  default_scope { order('name ASC') }

  has_many :post_tags
  has_many :posts, through: :post_tags

  validates :name, presence: true, uniqueness: true
end