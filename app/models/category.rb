class Category < ActiveRecord::Base
  default_scope { order('name ASC') }
  
  has_many :post_categories
  has_many :posts, through: :post_categories

  validates :name, presence: true, uniqueness: true
end
