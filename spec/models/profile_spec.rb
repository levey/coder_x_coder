require 'spec_helper'

describe Profile do
    
  let(:user) { FactoryGirl.create :user }
  before { @profile = user.build_profile(realname:"zhujiangang", location: "Hangzhou") }
  
  subject { @profile }
  
  it { should respond_to :realname }
  it { should respond_to :location }
  it { should respond_to :company }
  it { should respond_to :github  }
  it { should respond_to :twitter }
  it { should respond_to :weibo }
  it { should respond_to :bio }
  
  describe "when user_id is not present" do
    before { @profile.user_id = nil }
    it { should_not be_valid }
  end
end
