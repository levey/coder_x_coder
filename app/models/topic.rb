class Topic < ActiveRecord::Base

  attr_accessible :title, :content, :hits
  belongs_to :user
  
  has_many :comments, dependent: :destroy
  has_many :notifications, :as => :notifiable, :dependent => :destroy  
  
  validates :title, presence: true, length: { maximum: 120 }
  validates :user_id, presence: true
  
  scope :last_actived, order("topics.commented_at DESC, topics.created_at DESC")

  before_save :set_last_commented_at

  def set_last_commented_at
    self.commented_at = Time.now
  end

  def update_last_commented_at
    set_last_commented_at
    self.save
  end
  
end
