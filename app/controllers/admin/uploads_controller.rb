class Admin::UploadsController < AdminController
  def index
    @search_term = params[:search_term]
    @uploads = Upload.search_by_column(@search_term, params[:page], 'media_file_name')
  end

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
        format.json { render json: upload.errors, status: :bad_request }
        format.html do
          @upload = upload
          flash.now[:danger] = "Error, #{@upload.errors.full_messages[0]}."
          render :new
        end
      end
    end
  end

  def edit
    @upload = Upload.find(params[:id])
  end

  def destroy
    Upload.find(params[:id]).destroy
    flash[:success] = 'Upload deleted.'
    redirect_to admin_uploads_path
  end

  def update
    upload = Upload.find(params[:id])

    if upload.update(alt: params[:upload][:alt], description: params[:upload][:description])
      flash[:success] = 'Upload updated.'
      redirect_to edit_admin_upload_path(upload)
    else
      @upload = upload.reload
      flash.now[:danger] = "Error, #{@upload.errors.full_messages[0]}."
      render :edit
    end
  end
end
