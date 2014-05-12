class AdminController < ApplicationController
  layout 'layouts/admin'
  before_action :require_admin

  def require_admin
    redirect_to root_path unless (logged_in? && current_user.admin?)
  end
end
