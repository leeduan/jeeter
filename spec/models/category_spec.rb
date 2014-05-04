require 'spec_helper'

describe Category do
  it { should have_many(:posts).through(:post_categories) }
  it { should validate_presence_of(:name) }

  it 'should have default scope order of ascending by name' do
    sports = Fabricate(:category, name: 'Sports')
    news = Fabricate(:category, name: 'News')
    gossip = Fabricate(:category, name: 'Gossip')
    expect(Category.all).to eq([gossip, news, sports])
  end
end
