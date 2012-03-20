require 'spec_helper'

describe "TopicPages" do
  subject { page }
  
  let(:user) { FactoryGirl.create :user }
  before { sign_in user }
  
  describe "topic creation" do
    before { visit new_topic_path }
    
    describe "fill with invalid information" do
      
      it "should not create a topic" do
        expect { click_button "Post Topic" }.should_not change(Topic, :count)
      end
      
      describe "error message" do
        before { click_button "Post Topic" }
        it { should have_content("error") }
      end
      
    end 
    
    describe "fill with valid information" do
      before { fill_in "topic_title", with: "test title" }  
          
      it "should create a topic" do
        
        expect { click_button "Post Topic" }.should change(Topic, :count).by(1)
      end
    end
  end
end
