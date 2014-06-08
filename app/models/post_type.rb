class PostType < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true, uniqueness: true
end
