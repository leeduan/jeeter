require 'spec_helper'

describe Admin::PostsController do
  describe 'GET index' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { get :index }
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end

    context 'without page params' do
      let(:blog_type) { Fabricate(:post_type, name: 'Blog') }

      it 'assigns posts to @posts if less than 20 total posts' do
        post_first = Fabricate(:post, post_type: blog_type)
        post_second = Fabricate(:post, post_type: blog_type)
        get :index
        expect(assigns(:posts)).to eq([post_first, post_second])
      end

      it 'assigns the first 20 posts to @posts' do
        21.times { Fabricate(:post, post_type: blog_type) }
        get :index
        expect(assigns(:posts)).to eq(Post.first(20))
      end
    end

    context 'with page params' do
      let(:blog_type) { Fabricate(:post_type, name: 'Blog') }

      it 'assigns the 20 posts with correct offset to @posts' do
        41.times { Fabricate(:post, post_type: blog_type) }
        get :index, page: 2
        expect(assigns(:posts)).to eq(Post.limit(20).offset(20))
      end

      it 'assigns the remainder of posts to last page to @posts' do
        24.times { Fabricate(:post, post_type: blog_type) }
        get :index, page: 2
        expect(assigns(:posts)).to eq(Post.last(4))
      end
    end
  end

  describe 'DELETE destroy' do
    before { set_admin_user }

    let(:blog_type) { Fabricate(:post_type, name: 'Blog') }
    let(:post) { Fabricate(:post, post_type: blog_type) }

    it_behaves_like 'require admin' do
      let(:action) { delete :destroy, id: 1 }
    end

    it 'removes the post' do
      delete :destroy, id: post.id
      expect(Post.all).to be_empty
    end

    it 'renders the destroy template' do
      delete :destroy, id: post.id
      expect(response).to redirect_to admin_posts_path
    end
  end
end