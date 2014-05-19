require 'spec_helper'

describe Tag do
  it { should have_many(:posts).through(:post_tags) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }

  it 'should have default scope order of ascending by name' do
    nfl = Fabricate(:tag, name: 'NFL')
    nhl = Fabricate(:tag, name: 'NHL')
    mlb = Fabricate(:tag, name: 'MLB')
    expect(Tag.all).to eq([mlb, nfl, nhl])
  end
end
