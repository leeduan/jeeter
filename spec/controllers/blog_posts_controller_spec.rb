require 'spec_helper'

describe BlogPostsController do
  describe 'GET blog' do

    it_behaves_like 'recent blog posts' do
      let(:action) { get :index }
    end

    it_behaves_like 'blog categories' do
      let(:action) { get :index }
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    it 'assigns @posts in desc order' do
      blog_type = Fabricate(:post_type, name: 'Blog')
      last_post = Fabricate(:post, post_type: blog_type, published_at: Time.now-15)
      middle_post = Fabricate(:post, post_type: blog_type, published_at: Time.now-10)
      first_post = Fabricate(:post, post_type: blog_type, published_at: Time.now-5)
      get :index
      expect(assigns(:posts)).to eq([first_post, middle_post, last_post])
    end
  end
end
