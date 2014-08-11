class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:blog_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user if logged_in?

    respond_to do |format|
      if @comment.save
        format.json do
          template = render_to_string(
            partial: 'comments/comment',
            formats: [:html],
            locals: { comment: @comment })
          render json: { comment_template: template }, status: :created
        end
        format.html { redirect_to blog_path(@post), flash: { success: 'New comment created.' } }
      else
        format.json { render json: @comment.errors, status: :bad_request }
        format.html do
          @comments = @post.comments.reload
          flash.now[:danger] = 'Please fill out all required fields.'
          set_recent_posts
          set_categories
          render 'blog/show'
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :author_name, :author_email, :author_url, :parent_id)
  end
end
