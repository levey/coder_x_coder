class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :profile_attributes
  has_secure_password
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile
  
  
  # validates :name, presence: true, length: { :maximum => 20 }, uniqueness: { case_sensitive: false }
  validates :name, presence: true, format: { with:  /\w{3,20}/i }, uniqueness: { case_sensitive: false }
   
  validates :email, presence: true, format: { with:  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, 
            uniqueness: { case_sensitive: false }
  validates :password, length: { :minimum => 6 }                                       
  validates :password_confirmation, presence: true
  
  before_save :create_remember_token
  before_create :create_profile
  
  def to_param
    name
  end
  
  private
    
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
    
    def create_profile
      self.build_profile if self.profile.nil?
    end    
end
