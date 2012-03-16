class UsersController < ApplicationController
  
  def new
    @user = User.new
  end

  def show
    @user = User.find_by_name(params[:id])
    @user.build_profile unless @user.profile.present?
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to CXC"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by_name(params[:id])
  end
  
  def update
    @user = User.find_by_name(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated"
      sign_in @user
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end  
end
