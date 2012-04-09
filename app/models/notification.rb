class Notification < ActiveRecord::Base
  
  belongs_to :sender, class_name: "User", foreign_key: "sender_id" 
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id" 
  belongs_to :notifiable, :polymorphic => true
  
  attr_accessible :content, :read
  
  
  def self.save_notification(sender, receiver, notifiable, content)
    notification = Notification.new
    notification.sender = sender
    notification.receiver = receiver
    notification.notifiable = notifiable
    notification.content = content
    notification.save
  end
    
end
