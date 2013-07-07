require 'spec_helper'

describe "Micropst Pages" do
  subject { page }

  let(:user) { FactoryGirl.create(:user) }

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
end
