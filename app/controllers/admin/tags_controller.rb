class Admin::TagsController < AdminController
  def create
    @tags = Tag.createByInput(params[:new_tag])

    respond_to do |format|
      if @tags.any?
        format.json { render json: @tags, status: :created }
      else
        format.json { render json: { name: 'no valid tags' }, status: :bad_request }
      end
    end
  end
end