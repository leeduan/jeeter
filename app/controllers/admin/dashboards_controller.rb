class Admin::DashboardsController < AdminController
  before_action :set_recent_posts, :set_recent_comments

  def index; end
end
