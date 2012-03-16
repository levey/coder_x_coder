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
      
      it { should have_selector('title', text:user.name) }
      it { should have_link('Profile', href:user_path(user)) }
      it { should have_link('Account', href:edit_user_path(user)) }
      it { should have_link('Sign out', href:signout_path) }
    end
    
  end
end
