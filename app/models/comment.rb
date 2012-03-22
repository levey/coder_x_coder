class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic, :counter_cache => true
  
  validates_presence_of :user_id, :topic_id, :content
  
  
  after_save :update_topic
  
  private
  
    def update_topic
      topic.update_last_comment(self)
    end
  
end
