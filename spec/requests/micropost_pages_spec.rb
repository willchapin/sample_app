require 'spec_helper'

describe "Micropst Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before(:all) { 50.times { FactoryGirl.create(:micropost, user: user) } }
  after(:all) do 
    Micropost.delete_all
    User.delete_all
  end

  before do
    sign_in(user)
    visit root_path
  end
  

  describe "creating a new micropost" do
    describe "when content is invalid" do
      it "should not create a micropost" do
        expect { click_button 'Post' }.not_to change(Micropost, :count)
      end

      describe "error messages" do
        before { click_button "Post" }
        it { should have_content('error') }
      end
    end

    describe "when content is valid" do
      before { fill_in('micropost_content', with: Faker::Lorem.sentence) }
      it "should create a micropost" do
        expect { click_button 'Post' }.to change(Micropost, :count).by(1)
      end
    end
  end

  describe "micropost feed" do
    it { should have_content('Micropost Feed') } 
    it "should contain of the user's microposts" do
      user.microposts.each do |micropost|
        page.should have_selector('li', text: micropost.content)
      end
    end
  end
end
