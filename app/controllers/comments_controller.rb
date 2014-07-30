class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:blog_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user if logged_in?

    if @comment.save
      flash[:success] = 'New comment created.'
      redirect_to blog_path(@post)
    else
      flash.now[:danger] = 'Please fill out all required fields.'
      set_recent_posts
      set_categories
      @comments = @post.comments.reload
      render 'blog/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :author_name, :author_email, :author_url, :parent_id)
  end
end
