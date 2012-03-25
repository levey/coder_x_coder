require 'spec_helper'

describe Topic do
  let (:user) { FactoryGirl.create :user }
  
  before { @topic = user.topics.build(title: "Hello World!") }
  
  subject { @topic }
  
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  its(:user) { should == user }
  it { should respond_to(:content) }
  it { should respond_to(:hits) }
  
  it { should be_valid }
  
  describe "when user_id is not present" do
    before { @topic.user_id = nil }
    it { should_not be_valid }
  end
  
  describe "with blank title" do
    before { @topic.title = " " }
    it { should_not be_valid }
  end
  
  describe "with title that is too long" do
    before { @topic.title = "x" * 121 }
    it { should_not be_valid }
  end
  
end
