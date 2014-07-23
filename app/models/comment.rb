class Comment < ActiveRecord::Base
  default_scope { order('created_at DESC') }
  include Searchable

  belongs_to :user
  belongs_to :post

  validates_presence_of :content, :author_name, :author_email, :post_id
end