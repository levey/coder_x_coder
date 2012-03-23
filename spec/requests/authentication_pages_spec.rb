require 'spec_helper'

describe "AuthenticationPages" do
  subject { page }
  
  describe "signin page" do
    before { visit signin_path }
    
    it { should have_selector('title', text: generate_title("Sign in")) }    
    
    describe "with invalid information" do
      before { click_button "Sign in" }
      
      it { should have_selector('title', text: "Sign in") }
      it { should have_selector('div.alert.alert-error', text: "Invalid") }
      
      describe "after visiting another page" do
        before { click_link "Sign up" }
        it { should_not have_selector('div.alert.alert-error') }
      end
    end
    
    describe "with valid information" do
      let(:user) { FactoryGirl.create :user }
      before { sign_in user }
      
      it { should have_selector('title', text:user.username) }
      it { should have_link('Profile', href:user_path(user)) }
      it { should have_link('Account', href:edit_user_path(user)) }
      it { should have_link('Sign out', href:signout_path) }
    end
  end
  
  describe "authorization" do
    
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create :user }
      
      describe "in the Microposts controller" do
        
        describe "submitting to the create action" do
          before { post topics_path }
          specify { response.should redirect_to(signin_path) }
        end
        
        describe "submitting to the destroy action" do
          before do
            topic = FactoryGirl.create(:topic)
            delete topic_path(topic)
          end
          specify { response.should redirect_to(signin_path) }          
        end        
      end
    end
  end
  
end
