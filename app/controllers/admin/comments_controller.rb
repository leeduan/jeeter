class Admin::CommentsController < AdminController
  def index
    @search_term = params[:search_term]
    @comments = Comment.search_by_column(@search_term, params[:page], 'content')
  end

  def approve
    redirect_to admin_comments_path and return unless request.xhr?
    @comment = Comment.find(params[:id])

    if params[:approved] == 'true' || params[:approved] == 'false'
      @comment.update_attributes(approved: params[:approved])
      render json: @comment, status: :created
    else
      render json: { url: admin_comments_path }, status: :bad_request
    end
  end
end