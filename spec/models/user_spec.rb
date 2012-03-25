require 'spec_helper'

describe User do  
  before do
    @user = User.new(username: "Example User", email: "example@gmail.com", 
                     password: "whatever")
  end
  
  subject { @user }
  
  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:profile) }
  it { should respond_to(:topics) }
  it { should be_valid }
  
  # validate name 
  describe "when name is not present" do
    before { @user.username = "" }
    it { should_not be_valid }
  end
  
  # validate email
  describe "when email's format is not correct" do
    invailid_addresses = %w[user@company,com first_last_at_gmail.com]
    
    invailid_addresses.each do |address|
      before { @user.email = address }
      it { should_not be_valid }
    end
  end
  
  describe "when email's format is correct" do
    vailid_addresses = %w[user@company.com first_last@gmail.com hello@world.com first.last@gmail.com]
    
    vailid_addresses.each do |address|
      before { @user.email = address }
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
  
  # profile associations
  
  describe "profile associations" do
    before { @user.save }
    let (:profile) { @user.build_profile(realname: "zhujiangang", location: "hangzhou") }
    
    it "when deleted a user, the user's profile should be deleted" do
      @user.destroy
      Profile.find_by_id(profile.id).should be_nil
    end
  end
  
  # topic associations  
  describe "topic associations" do
    before { @user.save }
    
    it "should destroy associated topic when it's destroyed" do
      topics = @user.topics
      @user.destroy
      @user.topics.should be_empty
    end
  end
  
end
