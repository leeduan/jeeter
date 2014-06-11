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

  private

  def http_create
    tag = Tag.new(params.require(:tag).permit(:name, :description))

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