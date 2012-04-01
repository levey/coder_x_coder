class TopicsController < ApplicationController

  before_filter :authenticate_user!, :except => [:show, :index]
  
  def index
    @topics = Topic.last_actived.paginate(page: params[:page])
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
    @comments = @topic.comments.order('created_at ASC').paginate(page: params[:page])
    @page = params[:page]
    @page ||= 1;
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
end
