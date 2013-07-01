require 'spec_helper'

describe Micropost do

  let(:user)  { FactoryGirl.create(:user) }

  before do
    @micropost = user.microposts.build(content: "This is a test post!")
  end
  
  subject { @micropost }

  it { should respond_to(:user_id) }
  it { should respond_to(:content) }
  it { should respond_to(:user) }

  its(:user) { should == user }
  
  it { should be_valid }

  describe "accessible attributes" do
    it "should not allow access to user_id" do
      expect do
        Micropost.new(user_id: "1")
      end.to raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user_id is blank" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
end

