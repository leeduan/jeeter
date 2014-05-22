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

  describe 'GET new' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { get :new }
    end

    it 'assigns new Post to @post' do
      get :new
      expect(assigns(:post)).to be_instance_of(Post)
      expect(assigns(:post)).to be_new_record
    end

    it 'assigns Category.all to @categories' do
      sports = Fabricate(:category, name: 'Sports')
      news = Fabricate(:category, name: 'News')
      get :new
      expect(assigns(:categories)).to eq([news, sports])
    end

    it 'assigns PostType.all to @post_types' do
      blog_type = Fabricate(:post_type, name: 'Blog')
      press_type = Fabricate(:post_type, name: 'Press')
      get :new
      expect(assigns(:post_types)).to eq([blog_type, press_type])
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { post :create }
    end

    context 'valid post parameters' do
      it 'assigns flash success message' do
        post :create, post: Fabricate.attributes_for(:post, tags: '')
        expect(flash[:success]).to be_present
      end

      it 'assigns tags to post' do
        post :create, post: Fabricate.attributes_for(:post, tags: 'hello, jobs, what')
        expect(Post.first.tags.count).to eq(3)
      end

      it 'creates a new post' do
        post :create, post: Fabricate.attributes_for(:post, tags: '')
        expect(Post.count).to eq(1)
      end

      it 'redirects to admin_posts_path' do
        post :create, post: Fabricate.attributes_for(:post, tags: '')
        expect(response).to redirect_to admin_posts_path
      end
    end

    context 'invalid post parameters' do
      it 'assigns flash danger message' do
        post :create, post: Fabricate.attributes_for(:post, title: '')
        expect(flash[:danger]).to be_present
      end

      it 'assigns new Post to @post' do
        post :create, post: Fabricate.attributes_for(:post, title: '')
        expect(assigns(:post)).to be_instance_of(Post)
        expect(assigns(:post)).to be_new_record
      end

      it 'assigns Category.all to @categories' do
        sports = Fabricate(:category, name: 'Sports')
        news = Fabricate(:category, name: 'News')
        post :create, post: Fabricate.attributes_for(:post, title: '', category: sports)
        expect(assigns(:categories)).to eq([news, sports])
      end

      it 'assigns PostType.all to @post_types' do
        blog_type = Fabricate(:post_type, name: 'Blog')
        press_type = Fabricate(:post_type, name: 'Press')
        post :create, post: Fabricate.attributes_for(:post, title: '', post_type: blog_type)
        expect(assigns(:post_types)).to eq([blog_type, press_type])
      end

      it 'does not create a new post' do
        post :create, post: Fabricate.attributes_for(:post, title: '')
        expect(Post.count).to eq(0)
      end

      it 'renders the new template' do
        post :create, post: Fabricate.attributes_for(:post, title: '')
        expect(response).to render_template :new
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