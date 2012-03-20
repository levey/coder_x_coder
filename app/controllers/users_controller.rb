class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @plain_topics = @user.topics.paginate(page: params[:page])
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
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Account updated"
      sign_in @user
      redirect_to edit_user_path(@user)
    else
      render 'edit'
    end
  end  
  
  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(signin_path, notice: "Please sign in.") unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
  
end
