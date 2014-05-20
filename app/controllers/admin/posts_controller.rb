class Admin::PostsController < AdminController

  def index
    page = params[:page].to_i
    @posts = Post.page(page || 1)
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_posts_path
  end
end
