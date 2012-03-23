class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :profile_attributes
  
  attr_accessor :login
  USERNAME_REGAX = /\A[a-z0-9_]{3,15}/i
  validates :username, presence: true, format: { with: USERNAME_REGAX }, uniqueness: { case_sensitive: false } 
  
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  has_many :topics, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_create :create_profile
    
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.strip.downcase }]).first
  end
   
  def created_topics
    self.topics.order('created_at DESC')
  end

  def commented_topics
    topic_ids = self.comments.uniq.collect(&:topic_id)
    Topic.where(id: topic_ids).order('created_at DESC')
  end
  
  private
      
    def create_profile
      self.build_profile if self.profile.nil?
    end    
  
end
