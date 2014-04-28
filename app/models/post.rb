class Post < ActiveRecord::Base
  belongs_to :post_type
  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :post_type_id, presence: true
end
