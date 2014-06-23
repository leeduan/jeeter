class Admin::UploadsController < AdminController
  def new
    @upload_file = Upload.new
  end

  def create
    @upload_file = Upload.new(params.require(:upload).permit(:media))
    @upload_file.user = current_user

    if @upload_file.save
      flash[:success] = 'New file uploaded!'
      redirect_to new_admin_upload_path
    else
      flash[:danger] = "Error, #{@upload_file.errors.full_messages[0]}."
      render :new
    end
  end
end
