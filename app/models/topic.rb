class Topic < ActiveRecord::Base
  attr_accessible :title, :content, :hits
  belongs_to :user
  
  
  validates :title, presence: true, length: { maximum: 100 }
  validates :user_id, presence: true
  
  default_scope order: 'topics.created_at DESC'
  
end
