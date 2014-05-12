class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def set_recent_posts
    @recent_posts = PostType.blog_posts(5)
  end

  def set_categories
    @categories = Category.limit(5)
  end
end
