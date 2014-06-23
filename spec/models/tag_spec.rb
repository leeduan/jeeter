require 'rails_helper'

describe Tag do
  it { should have_many(:posts).through(:post_tags) }
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should ensure_length_of(:name) }

  it 'should have default scope order of ascending by name' do
    nfl = Fabricate(:tag, name: 'NFL')
    nhl = Fabricate(:tag, name: 'NHL')
    mlb = Fabricate(:tag, name: 'MLB')
    expect(Tag.all).to eq([mlb, nfl, nhl])
  end

  describe 'self#createByInput' do
    it 'should return empty array if argument of empty string' do
      expect(Tag.createByInput('')).to eq([])
    end

    it 'should return empty array if argument is empty space' do
      expect(Tag.createByInput(' ')).to eq([])
    end

    it 'should return array of tag objects from comma separated argument' do
      expect(Tag.createByInput('insights, behaviors, logic').count).to eq(3)
    end

    it 'should not return the same two tag objects' do
      expect(Tag.createByInput('insights, insights').count).to eq(1)
    end

    it 'should return array of tag objects even if tag already exist' do
      Fabricate(:tag, name: 'insights')
      Fabricate(:tag, name: 'behaviors')
      expect(Tag.createByInput('insights, behaviors, logic').count).to eq(3)
    end
  end
end
