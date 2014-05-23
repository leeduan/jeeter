class Admin::PostsController < AdminController

  def index
    page = params[:page].to_i
    @posts = Post.page(page || 1)
  end

  def new
    @post = Post.new
    @categories = Category.all
    @post_types = PostType.all
  end

  def create
    post = Post.new(post_params)
    post.user = current_user

    if post.valid?
      post.tags = Tag.handleInput(params[:post][:tags])
      post.save
      flash[:success] = 'New post created.'
      redirect_to admin_posts_path
    else
      flash[:danger] = 'Please fill in all required fields.'
      @post = post
      @categories = Category.all
      @post_types = PostType.all
      render :new
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to admin_posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :post_type_id, :category_ids => [])
  end
end
