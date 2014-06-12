class Admin::CategoriesController < AdminController
  def index
    @search_term = params[:search_term]
    @categories = Category.search_by_column(@search_term, params[:page], 'name')
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.json { render json: @category, status: :created }
        format.html { redirect_to admin_categories_path, flash: { success: 'New category created.' } }
      else
        format.json { render json: @category.errors, status: :bad_request }
        format.html { redirect_to admin_categories_path, flash: { danger: "Error, #{@category.errors.full_messages[0]}." } }
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    category = Category.find(params[:id])
    category.update(category_params)

    if category.save
      flash[:success] = 'Category updated.'
      redirect_to admin_categories_path
    else
      flash.now[:danger] = "Error, #{category.errors.full_messages[0]}."
      @category = category
      render :edit
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :description)
  end
end