class Comment < ActiveRecord::Base
  MENTION_REGEXP = /@(\p{Word}+)/u
  
  belongs_to :user
  belongs_to :topic, :counter_cache => true
  attr_protected :user_id, :topic_id
  
  validates_presence_of :content
  
  default_scope order('created_at ASC')

  after_save :send_notifications
  after_save :update_topic
  
  def has_mentions?
    self.content =~ MENTION_REGEXP
  end
  
  def mentioned_users
    mentioned_names = self.content.scan(MENTION_REGEXP).collect {|matched| matched.first}.uniq
    mentioned_names.delete(self.user.username)
    mentioned_names.delete(self.topic.user.username)
    mentioned_names.map { |name| User.find_by_username(name) }.compact
  end
  
  private
  
    def update_topic
      topic.update_last_commented_at
    end
    
    def send_notifications
      unless self.user == self.topic.user
        send_notification_to(self.topic.user, self.topic)     
      end
      send_notification_to_mentioned_users if self.has_mentions?
    end
    
    def send_notification_to_mentioned_users
      mentioned_users.each do |receiver|
        send_notification_to(receiver, self)
      end
    end
    
    def send_notification_to(receiver, notifiable)
      Notification.save_notification(self.user, receiver, notifiable, self.content)
    end
      
end
