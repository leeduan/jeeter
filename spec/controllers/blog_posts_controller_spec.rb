require 'spec_helper'

describe BlogPostsController do
  describe 'GET blog' do
    before do
      post_type = Fabricate(:post_type, name: 'Blog')
      3.times { Fabricate(:post, post_type: post_type) }
      get :index
    end

    it 'renders the index template' do
      expect(response).to render_template :index
    end

    it 'assigns @posts' do
      expect(assigns(:posts)).to be_present
    end
  end
end
