class Admin::SessionsController < ApplicationController
  layout 'layouts/basic'

  def new; end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_path
    else
      render :index
    end
  end
end
