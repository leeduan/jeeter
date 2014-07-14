class Admin::UploadsController < AdminController
  def new
    @upload = Upload.new
  end

  def create
    upload = Upload.new(params.require(:upload).permit(:media))
    upload.user = current_user

    respond_to do |format|
      if upload.save
        format.json { render json: upload, status: :created }
        format.html { redirect_to new_admin_upload_path, flash: { success: 'New file uploaded.' } }
      else
        unless request.xhr?
          @upload = upload
          flash.now[:danger] = "Error, #{@upload.errors.full_messages[0]}."
        end
        format.json { render json: upload.errors, status: :bad_request }
        format.html { render :new }
      end
    end
  end
end
