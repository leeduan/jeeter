class User < ActiveRecord::Base
  has_many :posts
  has_many :comments
  has_many :uploads

  validates :full_name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  has_secure_password validations: false
end
