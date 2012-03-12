require 'spec_helper'


describe "Static Pages" do
  
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_content('Welcome') }
    it { should have_selector('title', text: generate_title('Home')) }
  end
  
end
