class Admin::CommentsController < AdminController
  def index
    @search_term = params[:search_term]
    @comments = Comment.search_by_column(@search_term, params[:page], 'comment')
  end
end