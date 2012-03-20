class TopicsController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy]
  before_filter :correct_user,   only: [:edit, :update, :destroy]
  
  def index
    @topics = Topic.order('created_at DESC').paginate(page: params[:page])
  end
  
  def new
    @topic = Topic.new
  end
  
  def create
    @topic = current_user.topics.build(params[:topic])
    if @topic && @topic.save
      flash[:success] = "Topic have been posted."
      redirect_to topic_path @topic
    else
      render 'new'
    end
  end
  
  def show
    @topic = Topic.find(params[:id])
  end
  
  def edit
    @topic = Topic.find(params[:id])
  end
  
  def update
    @topic = Topic.find(params[:id])
    if @topic && @topic.update_attributes(params[:topic])
      flash[:success] = "Topic updated."
      redirect_to topic_path @topic
    else
      render 'edit'
    end
  end
  
  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:success] = "Topic deleted."
      redirect_to topics_path
    else
      render 'edit'
    end
  end  
  
  private

    def correct_user
      @user = Topic.find(params[:id]).user
      redirect_to(signin_path, notice: "Please sign in.") unless current_user?(@user)
    end
  
end
