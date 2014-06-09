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

  describe 'self#search_by_column' do
    it 'returns categories with matching names' do
      global_news = Fabricate(:category, name: 'Global News')
      local_news = Fabricate(:category, name: 'Local News')
      sports = Fabricate(:category, name: 'Sports')
      opinion = Fabricate(:category, name: 'Opinion')
      science = Fabricate(:category, name: 'Science')
      expect(Category.search_by_column('News', nil, 'name')).to eq([global_news, local_news])
    end

    it 'returns the categories of the correct page' do
      20.times { |i| Fabricate(:category, name: "category #{i}") }
      news = Fabricate(:category, name: 'News')
      sports = Fabricate(:category, name: 'Sports')
      opinion = Fabricate(:category, name: 'Opinion')
      expect(Category.search_by_column(nil, '2', 'name')).to eq([news, opinion, sports])
    end

    it 'returns first page categories if no page number entered' do
      def number_to_letter(number = 1) number.to_i.to_s(27).tr("0-9a-q", "A-Z") end
      page_one_categories = 20.times.map {|i| Fabricate(:category, name: "#{number_to_letter(i)}") }
      4.times { |i| Fabricate(:category, name: "zend #{number_to_letter(i)}") }
      expect(Category.search_by_column(nil, nil, 'name')).to eq(page_one_categories)
    end
  end
end
