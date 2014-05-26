class Admin::PostsController < AdminController

  def index
    @search_term = params[:search_term];
    @posts = Post.search_by_title(@search_term, params[:page])
  end

  def new
    @post = Post.new(published_at: Time.now)
    @categories = Category.all
    @post_types = PostType.all
  end

  def create
    post = Post.new(post_params)
    post.user = current_user

    if post.valid?
      post.tags = Tag.createByInput(params[:post][:tags])
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
    params[:post][:publish_status] = params[:post][:publish_status] === 'true' ? true : false
    params.require(:post).permit(
      :title,
      :content,
      :post_type_id,
      :publish_status,
      :published_at,
      :category_ids => []
    )
  end
end
