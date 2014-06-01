class BlogController < ApplicationController
  before_action :set_recent_posts, :set_categories

  def index
    @posts = Post.blog_posts_only.page(params[:page]).per(5)
  end

  def show
    @post = Post.blog_posts_only.find(params[:id])
  end
end
