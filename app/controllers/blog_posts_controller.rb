class BlogPostsController < ApplicationController
  before_action :set_recent_posts, :set_categories

  def index
    @posts = PostType.blog_posts
  end
end
