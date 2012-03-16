class Profile < ActiveRecord::Base
  attr_accessible :realname, :location, :company, :blog, :github, :twitter, :weibo, :bio
  belongs_to :user
  
  validates :user_id, presence: true

  def to_param
    user.name.parameterize
  end

end
