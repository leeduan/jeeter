class BlogPostsController < ApplicationController
  before_action :set_recent_posts, :set_categories

  def index
    @posts = blog_post_type.posts
  end

  private

  def set_recent_posts
    @recent_posts = blog_post_type.posts.limit(5)
  end

  def set_categories
    @categories = Category.limit(10).order(name: :asc)
  end

  def blog_post_type
    @blog_post_type ||= PostType.find_or_create_by(name: 'Blog')
  end
end
