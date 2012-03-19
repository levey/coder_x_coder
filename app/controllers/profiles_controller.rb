class ProfilesController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update]
  before_filter :correct_user,   only: [:edit, :update]
  
  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      flash[:success] = "Profile Updated"
      redirect_to edit_profile_path(@profile)
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
