class ProfilesController < ApplicationController
  
  def update
    @profile = Profile.find(params[:id])
    if @profile.update_attributes(params[:profile])
      flash[:success] = "Profile updated"
      redirect_to edit_profile_path(@profile)
    else
      render 'edit'
    end
  end
  
end
