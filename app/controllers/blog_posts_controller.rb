class BlogPostsController < ApplicationController
  before_action :set_recent_posts, :set_categories

  def index
    @posts = PostType.find_by(name: 'Blog').posts
  end

  private

  def set_recent_posts
    @recent_posts = PostType.find_by(name: 'Blog').posts.limit(5)
  end

  def set_categories
    @categories = Category.limit(10).order(name: :asc)
  end
end
