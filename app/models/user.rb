class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  
  validates :name, :presence => true, :length => { :maximum => 20 }
  validates :email, :presence => true, :format => { :with =>  /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  :uniqueness => { case_sensitive: false }
  validates :password, :length => { :minimum => 6 }                                       
  validates :password_confirmation, :presence => true
  
end
