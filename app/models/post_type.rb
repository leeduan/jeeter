class PostType < ActiveRecord::Base
  has_many :posts, -> { order('created_at DESC') }
  validates :name, presence: true, uniqueness: true
end
