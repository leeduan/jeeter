class Blog::CategoriesController < ApplicationController
  before_action :set_recent_posts, :set_categories

  def show
    category = Category.find(params[:id])
    @posts = category.posts.blog_posts_only.page(params[:page]).per(10)
  end
end
