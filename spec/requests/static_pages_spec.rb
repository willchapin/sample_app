require 'spec_helper'

describe "Static pages" do
  
  subject { page }
    
  describe "Home page" do
    before { visit root_path }
    it { should have_selector('h1', :text => 'Sample App') }
    it { should have_selector('title',:text => full_title('')) }
    it { should_not have_selector('title', :text => '| Home') }

    describe "For signed in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:other_micropost) { FactoryGirl.create(:micropost) }

      before do
        31.times { FactoryGirl.create(:micropost, user: user) }
        sign_in(user)
        visit root_path
      end

      it { should have_selector('div.pagination') }

      it "should render the user's feed" do
        user.feed.paginate(page: 1).each do |item|
          page.should have_selector("li##{item.id}", text: item.content)
        end
      end

      it "should be able to delete own microposts" do
        expect { click_link('delete') }.to change(Micropost, :count).by(-1)
      end

      it "should not have a delete option for other user's microposts" do
        page.should_not have_selector("li##{other_micropost.id}", text: 'delete')
      end

      describe "following/followers counts" do
        let(:follower) { FactoryGirl.create(:user) }
        before do
          follower.follow!(user)
          visit root_path
        end

        it { should have_link '0 following', href: following_user_path(user) }
        it { should have_link '1 followers', href: followers_user_path(user) }

      end

    end
  end

  describe "Help page" do
    before {visit help_path}
    it { should have_selector('h1', :text => 'Help') }
    it { should have_selector('title', :text => full_title('Help')) }
  end

  describe "About page" do
    before {visit about_path}
    it { should have_selector('h1', :text => 'About') }
    it { should have_selector('title', :text => full_title('About')) }
  end
  
  describe "Contact page" do
    before {visit contact_path}
    it { should have_selector('h1', :text => 'Contact') }
    it { should have_selector('title', :text => full_title('Contact')) }
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link "Sign in"
    page.should have_selector 'title', text: full_title('Sign in')
    click_link "About"
    page.should have_selector 'title', text: full_title('About Us')
    click_link "Help"
    page.should have_selector 'title', text: full_title('Help')
    click_link "Contact"
    page.should have_selector 'title', text: full_title('Contact')
    click_link "Home"
    click_link "Sign up now!"
    page.should have_selector 'title', text: full_title('Sign up')
  end
  
end
