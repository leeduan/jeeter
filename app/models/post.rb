class Post < ActiveRecord::Base
  belongs_to :user
  belongs_to :post_type
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :post_type_id, presence: true
end
