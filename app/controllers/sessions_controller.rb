class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_name(params[:session][:name_or_email])
    user ||= User.find_by_email(params[:session][:name_or_email])

    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
      # redirect_back_or user
    else
      flash.now[:error] = 'Invalid name or password'
      render 'new'
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end
  
end
