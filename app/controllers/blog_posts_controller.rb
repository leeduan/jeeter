class BlogPostsController < ApplicationController
  def index
    @posts = PostType.find_by(name: 'Blog').posts
  end
end
