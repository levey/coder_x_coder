class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic, :counter_cache => true
  attr_protected :user_id, :topic_id
  
  validates_presence_of :content
  
  default_scope order('created_at ASC')

  after_save :send_notifications
  after_save :update_topic
  
  private
  
    def update_topic
      topic.update_last_commented_at
    end
    
    def send_notifications
      unless self.user == self.topic.user
        Notification.save_notification(self.user, self.topic.user, self.topic, self.content)      
      end
    end
  
end
