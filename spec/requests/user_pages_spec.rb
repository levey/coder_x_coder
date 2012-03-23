require 'spec_helper'

describe "User pages" do
  
  subject { page }
  
  # profile page
  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    
    before { visit user_path(user) }
    
    it { should have_selector('title',text: user.username) }
    it { should have_selector('h1', text: user.username) }
  end
  
  
  # sign up
  describe "signup page" do
    before { visit signup_path }
    
    it { should have_selector('title', text: generate_title("Sign up")) }    
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Create my CXC account" }.not_to change(User, :count)
      end
      
      describe "show error message" do
        before { click_button "Create my CXC account" }
        
        it { should have_selector('title', text: "Sign up") }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      before do
        fill_in "Name", with: "Example User"
        fill_in "Email", with: "user@gmail.com"
        fill_in "Password", with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect do
          click_button "Create my CXC account"
        end.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button "Create my CXC account" }
        let(:user) { User.find_by_name "Example User" }
        
        it { should have_selector('div.alert.alert-success', text: "Welcome") }
        it { should have_link("Sign out") }
        
        describe "followed by signout" do
          before { click_link "Sign out" }
          it { should have_link("Sign in") }
          it { should have_link("Sign up") }
        end
        
      end
    end
  end  
  
  # setting  
  
  describe "setting" do
    let(:user) { FactoryGirl.create :user }
    before do
      sign_in user
      visit edit_user_path(user)
    end
    
    describe "page" do
      it { should have_selector('title', text:generate_title("Account")) }
    end
    
    describe "fill in invalid information" do
      before { click_button "Save account changes" }
      
      it { should have_content("error") }
    end
    
    describe "fill in valid information" do
      let(:new_name) { "New name" }
      let(:new_email) { "new@email.com" }
      
      before do
        fill_in "Name", with: new_name
        fill_in "Email", with: new_email
        fill_in "Password", with: user.password
        fill_in "Confirmation", with: user.password
        click_button "Save account changes"
      end
      
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Sign out', href: signout_path) }
      specify { user.reload.name.should == new_name }
      specify { user.reload.email.should == new_email }
    end
  end
end
