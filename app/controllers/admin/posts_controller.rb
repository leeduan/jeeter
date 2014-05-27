class Admin::PostsController < AdminController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_tags_categories, only: [:new, :create, :edit, :update]

  def index
    @search_term = params[:search_term]
    @posts = Post.search_by_title(@search_term, params[:page])
  end

  def new
    @post = Post.new(published_at: Time.now)
  end

  def create
    post = Post.new(post_params)
    post.user = current_user

    if post.save
      flash[:success] = 'New post created.'
      redirect_to admin_posts_path
    else
      flash[:danger] = 'Please fill in all required fields.'
      @post = post
      render :new
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:success] = "Post was updated."
      redirect_to admin_posts_path
    else
      flash[:danger] = 'Please fill in all required fields.'
      render :edit
    end
  end

  def destroy
    @post.destroy
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
      :category_ids => [],
      :tag_ids => []
    )
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def set_tags_categories
    @categories = Category.all
    @post_types = PostType.all
  end
end
