class Blog::UsersController < ApplicationController
  before_action :set_recent_posts, :set_categories

  def show
    user = User.find(params[:id])
    @posts = user.posts.blog_posts_only.page(params[:page]).per(10)
  end
end
