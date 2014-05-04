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
      time_interval = 5
      decrement_time = 0
      blog_type = Fabricate(:post_type, name: 'Blog')

      3.times do
        Fabricate(:post, post_type: blog_type, created_at: Time.now - decrement_time)
        decrement_time -= time_interval
      end

      get :index
      expect(assigns(:posts)).to eq(Post.all.reverse)
    end
  end
end
