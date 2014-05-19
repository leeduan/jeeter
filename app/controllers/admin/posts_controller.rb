class Admin::PostsController < AdminController

  def index
    page = params[:page].to_i
    @posts = Post.page(page || 1)
  end
end
