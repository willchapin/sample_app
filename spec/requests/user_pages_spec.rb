require 'spec_helper'

describe "User Pages" do
  subject { page }
  
  describe "signup page" do
    before { visit signup_path }
    it { should have_selector('h1', text: 'Sign up') }
    it { should have_selector('title', text: full_title('Sign up')) }
  end
  
  describe "profile page" do
    let(:test_user) { FactoryGirl.create(:user) }
    
    before { visit user_path(test_user) }
    
    it { should have_selector('h1', text: test_user.name) }
    it { should have_selector('title', text: test_user.name) }
  end
  
  describe "signup" do
    before { visit signup_path }
    
    let(:submit) { "Create my account" }
    
    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
        before { click_button submit }
        it { should have_selector('title', text: 'Sign up') }
        it { should have_content('error') }
      end
    end
    
    describe "with valid information" do
      
      before do
        fill_in "Name",         with: "Test Name"
        fill_in "Email",        with: "testemail@fake.test"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end
      
      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end 
      
      describe "after saving a user" do
        
        before { click_button submit }
        
        let(:user) { User.find_by_email("testemail@fake.test") }
        
        it { should have_selector('title', text: user.name) }
      end
      
      describe "after submission" do
        before { click_button submit }
        let(:user) { User.find_by_email("testemail@fake.test") }
        it { should have_selector('div.alert.alert-success', text: 'Welcome to the Sample App!') }
        it { should have_selector('title', text: user.name) }
      end
    end
    
    
    
    
  end
end
