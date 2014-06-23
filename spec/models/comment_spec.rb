require 'rails_helper'

describe Comment do
  it { should belong_to(:post) }
  it { should belong_to(:user) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:author_name) }
  it { should validate_presence_of(:author_email) }
  it { should validate_presence_of(:post_id) }

  it 'should have default scope order of descending by created_at' do
    last_comment = Fabricate(:comment)
    first_comment = Fabricate(:comment, created_at: Time.now-10)
    middle_comment = Fabricate(:comment, created_at: Time.now-5)
    expect(Comment.all).to eq([last_comment, middle_comment, first_comment])
  end
end
