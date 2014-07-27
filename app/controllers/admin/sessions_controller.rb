class Admin::SessionsController < ApplicationController
  layout 'layouts/basic'

  def new; end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to admin_path
    else
      flash.now[:danger] = 'Invalid username or password.'
      render :index
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have logged out.'
    redirect_to root_path
  end
end
