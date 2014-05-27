class Admin::CategoriesController < AdminController
  def create
    @category = Category.new(params.require(:category).permit(:name))

    respond_to do |format|
      if @category.save
        format.json { render json: @category, status: :created }
      else
        format.json { render json: @category.errors, status: :bad_request }
      end
    end
  end
end