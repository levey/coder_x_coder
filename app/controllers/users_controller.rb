class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => :show
  
  def new
    @user = User.new
  end
    
  def show
    @user = User.find(params[:id])
    @created_topics = @user.created_topics.paginate(page: params[:page])
    @commented_topics = @user.commented_topics.paginate(page: params[:page])
    @user.build_profile unless @user.profile.present?
  end
  
end
