class Admin::TagsController < AdminController
  def index
    @search_term = params[:search_term]
    @tags = Tag.search_by_column(@search_term, params[:page], 'name')
    @tag = Tag.new
  end

  def create
    xhr_create and return if request.xhr?
    http_create
  end

  def edit
    @tag = Tag.find(params[:id])
  end

  def update
    tag = Tag.find(params[:id])
    tag.update(tag_params)

    if tag.save
      flash[:success] = 'Tag updated.'
      redirect_to admin_tags_path
    else
      flash.now[:danger] = "Error, #{tag.errors.full_messages[0]}."
      @tag = tag
      render :edit
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :description)
  end

  def http_create
    tag = Tag.new(tag_params)

    if tag.save
      flash[:success] = 'New tag created.'
      redirect_to admin_tags_path
    else
      flash[:danger] = "Error, #{tag.errors.full_messages[0]}."
      redirect_to admin_tags_path
    end
  end

  def xhr_create
    tags = Tag.createByInput(params[:new_tag])

    if tags.any?
      render json: tags, status: :created
    else
      render json: { name: 'no valid tags' }, status: :bad_request
    end
  end
end