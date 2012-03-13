require 'spec_helper'

describe "User pages" do
  
  subject { page }
  
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    
    before { visit user_path(user) }
    
    it { should have_selector('title',:text => user.name) }
    it { should have_selector('h1', :text => user.name) }
  end
  
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('title', :text => generate_title("Sign up")) }    
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create my coderXcoder account" }.not_to change(User, :count)
      end
      
      describe "show error message" do
        before { click_button "Create my coderXcoder account" }
        
        it { should have_selector('title', :text => "Sign up") }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name", :with => "Example User"
        fill_in "Email", :with => "user@gmail.com"
        fill_in "Password", :with => "foobar"
        fill_in "Confirmation", :with => "foobar"
      end
      
      it "should create a user" do
        expect do
          click_button "Create my coderXcoder account"
        end.to change(User, :count).by(1)
      end
    end
  end  
end
