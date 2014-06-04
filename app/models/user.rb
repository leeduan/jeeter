class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  validates :full_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  has_secure_password validations: false
end
