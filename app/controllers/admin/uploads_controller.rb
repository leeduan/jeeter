class Admin::UploadsController < AdminController
  def new
    @upload = Upload.new
  end

  def create
    upload = Upload.new(params.require(:upload).permit(:media))
    upload.user = current_user

    if upload.save
      flash[:success] = 'New file uploaded!'
      redirect_to new_admin_upload_path
    else
      @upload = upload
      flash.now[:danger] = "Error, #{@upload.errors.full_messages[0]}."
      render :new
    end
  end
end
