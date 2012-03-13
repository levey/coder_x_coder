require 'spec_helper'

describe User do
  before do
    @user = User.new(name: "Example User", email: "example@gmail.com", 
                     password: "whatever", password_confirmation: "whatever")
  end
  
  subject { @user }
  
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }
  it { should be_valid }
  
  # validate name 
  describe "when name is not present" do
    before { @user.name = "" }
    it { should_not be_valid }
  end
  
  describe "when name is too long" do
    before { @user.name = "a" * 21 }
    it { should_not be_valid }
  end
  
  # validate email
  describe "when email's format is not correct" do
    vailid_addresses = %w[user@company,com first_last_at_gmail.com]
    
    vailid_addresses.each do |addressed|
      before { @user.name = addressed }
      it { should_not be_valid }
    end
  end
  
  describe "when email's format is correct" do
    invailid_addresses = %w[user@company.com first_last@gmail.com hello@world.com first.last@gmail.com]
    
    invailid_addresses.each do |addressed|
      before { @user.name = addressed }
      it { should be_valid }
    end
  end
  
  describe "when email is already token" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end
    
    it { should_not be_valid }
  end
  
  # validate password
  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end
  
  describe "when passwords doesn't match" do
    before { @user.password_confirmation = "balabala" }
    it { should_not be_valid }
  end
  
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end
  
  describe "when password is too short" do
    before { @user.password = @user.password_confirmation = "short" }
    it { should_not be_valid }
  end
  
  # authentication
  
  describe "return value of authenticate method" do
      before { @user.save }
      let (:found_user) { User.find_by_email @user.email }
    
    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end
  
    describe "with invalid password" do
      let (:user_for_invalid_password) { found_user.authenticate("invalidpwd") }
    
      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
  
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end

  
end
