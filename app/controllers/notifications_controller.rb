class NotificationsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    current_user.notifications.update_all(read: true)
    @notifications = current_user.notifications.order('created_at DESC').page(params[:page])    
  end
end
