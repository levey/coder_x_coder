class TopicsController < ApplicationController
  
  def index
    @topics = Topic.order('created_at DESC').paginate(page: params[:page])
  end
  
  def create
    
  end
  
  def destroy
  
  end  
  
end
