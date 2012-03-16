class ProfilesController < ApplicationController
  
  def update
    @profile = User.find_by_name(params[:id]).profile
    if @profile.update_attributes(params[:profile])
      flash[:success] = "Profile Updated"
      redirect_to edit_profile_path(@profile)
    else
      render 'edit'
    end
  end
end
