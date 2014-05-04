class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def set_recent_posts
    @recent_posts = PostType.blog_posts(5)
  end

  def set_categories
    @categories = Category.limit(5)
  end
end
