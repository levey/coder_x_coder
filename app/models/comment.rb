class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic, :counter_cache => true
  attr_protected :user_id, :topic_id
  
  validates_presence_of :content
  
  default_scope order('created_at ASC')

  after_save :update_topic
  
  private
  
    def update_topic
      topic.update_last_comment(self)
    end
  
end
