require 'spec_helper'

describe Post do
  it { should belong_to(:user) }
  it { should belong_to(:post_type) }
  it { should have_many(:comments) }
  it { should have_many(:categories).through(:post_categories) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:post_type_id) }
  it { should validate_uniqueness_of(:title) }

  it 'should have default scope order of desc by created_at' do
    blog_type = Fabricate(:post_type, name:'Blog')
    lambo = Fabricate(:post, post_type: blog_type, title:'Lamborghini Aventador', published_at: Time.now-5)
    ferrari = Fabricate(:post, post_type: blog_type, title:'Ferrari 458', published_at: Time.now-25)
    bugatti = Fabricate(:post, post_type: blog_type, title:'Bugatti Veyron', published_at: Time.now)
    expect(Post.all).to eq([bugatti, lambo, ferrari])
  end

  describe 'self#search_by_title' do
    let(:blog_type) { Fabricate(:post_type, name: 'blog') }

    it 'returns posts with matching titles' do
      bmw_x5 = Fabricate(:post, post_type: blog_type, title: 'BMW X5 Review', published_at: Time.now)
      mercedes_ml = Fabricate(:post, post_type: blog_type, title: 'Mercedes ML Preview', published_at: Time.now+1)
      audi_q7 = Fabricate(:post, post_type: blog_type, title: 'Audio Q7 Preview', published_at: Time.now+2)
      porsche_cayenne = Fabricate(:post, post_type: blog_type, title: 'Porsche Cayenne Review', published_at: Time.now+3)
      expect(Post.search_by_title('Preview')).to eq([audi_q7, mercedes_ml])
    end

    it 'returns the posts of the correct page' do
      20.times { Fabricate(:post, post_type: blog_type, published_at: Time.now) }
      os_x = Fabricate(:post, post_type: blog_type, title: 'Mac OS X', published_at: Time.now-20)
      windows = Fabricate(:post, post_type: blog_type, title: 'Microsoft Windows', published_at: Time.now-15)
      ubuntu = Fabricate(:post, post_type: blog_type, title: 'Ubuntu', published_at: Time.now-10)
      expect(Post.search_by_title(nil, '2')).to eq([ubuntu, windows, os_x])
    end

    it 'returns first page posts if no page number entered' do
      page_one_posts = 20.times.map {|i| Fabricate(:post, post_type: blog_type, published_at: Time.now+i) }
      4.times { Fabricate(:post, post_type: blog_type, published_at: Time.now - 60) }
      expect(Post.search_by_title()).to eq(page_one_posts.reverse)
    end
  end

  describe '#publish_status_name' do
    it 'returns "Published" if publish_status is true and Time.now is after/equal published_at' do
      post = Fabricate(:post, publish_status: true)
      expect(post.publish_status_name).to eq('Published')
    end

    it 'returns "Pending" if publish_status is true and Time.now is before published_at' do
      post = Fabricate(:post, publish_status: true, published_at: Time.now + 60)
      expect(post.publish_status_name).to eq('Pending')
    end

    it 'returns "Draft" if publish_status is false' do
      post = Fabricate(:post, publish_status: false)
      expect(post.publish_status_name).to eq('Draft')
    end
  end
end
