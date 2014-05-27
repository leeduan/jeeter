class PostType < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true, uniqueness: true

  def self.blog_posts(n = nil)
    @blog_post_type ||= find_or_create_by(name: 'Blog')
    @blog_post_type.posts.limit(n)
  end
end
