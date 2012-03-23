class Topic < ActiveRecord::Base
  attr_accessible :title, :content, :hits
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  
  validates :title, presence: true, length: { maximum: 120 }
  validates :user_id, presence: true
  
  scope :last_actived, order("topics.commented_at DESC, topics.created_at DESC")
  
  def update_last_comment(comment)
    self.commented_at = Time.now
    self.save
  end
  
end
