class CommentsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @topic = Topic.find(params[:topic_id])
    @comment = @topic.comments.build(params[:comment])
    @comment.user = current_user
    if @comment.save
      flash[:success] = "Comment posted."
      redirect_to @comment.topic
    else
      flash[:error] = "Comment not posted."
      redirect_to @comment.topic
    end
  end
      
end
