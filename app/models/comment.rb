class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :topic, :counter_cache => true
  
  validates_presence_of :user_id, :topic_id, :content
end
