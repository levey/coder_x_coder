class ProfilesController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  
  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      flash[:success] = "Profile Updated"
      redirect_to edit_profile_path(@profile)
    else
      render 'edit'
    end
  end
  
  
end
