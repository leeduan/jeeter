require 'spec_helper'

describe BlogPostsController do
  describe 'GET blog' do
    let!(:post_type) { Fabricate(:post_type, name: 'Blog') }

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns @posts in desc order' do
      3.times.map { |i| Fabricate(:post, post_type: post_type, created_at: Time.now + i) }
      get :index
      expect(assigns(:posts)).to eq(Post.all.reverse)
    end

    it 'assigns five @recent_posts in desc order' do
      6.times.map { |i| Fabricate(:post, post_type: post_type, created_at: Time.now + i ) }
      get :index
      expect(assigns(:recent_posts)).to eq(Post.last(5).reverse)
    end

    it 'assigns @categories in asc name order' do
      news = Fabricate(:category, name: 'News')
      sports = Fabricate(:category, name: 'Sports')
      gossip = Fabricate(:category, name: 'Gossip')
      get :index
      expect(assigns(:categories)).to eq([gossip, news, sports])
    end
  end
end
