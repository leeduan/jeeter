require 'spec_helper'

describe Admin::PostsController do
  describe 'GET index' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { get :index }
    end

    it 'assigns @search_term' do
      get :index, search_term: 'hello'
      expect(assigns(:search_term)).to eq('hello')
    end

    it 'assigns @posts' do
      blog_type = Fabricate(:post_type, name: 'Blog')
      last_post = Fabricate(:post, post_type: blog_type, published_at: Time.now-1)
      first_post = Fabricate(:post, post_type: blog_type, published_at: Time.now)
      get :index
      expect(assigns(:posts)).to eq([first_post, last_post])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
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

    context 'with valid params' do
      it 'assigns flash success message' do
        post :create, post: Fabricate.attributes_for(:post)
        expect(flash[:success]).to be_present
      end

      it 'assigns tags to post' do
        tags = 3.times.map { Fabricate(:tag).id }
        post :create, post: Fabricate.attributes_for(:post, tag_ids: tags)
        expect(Post.first.tags.count).to eq(3)
      end

      it 'creates a new post' do
        post :create, post: Fabricate.attributes_for(:post)
        expect(Post.count).to eq(1)
      end

      it 'redirects to admin_posts_path' do
        post :create, post: Fabricate.attributes_for(:post)
        expect(response).to redirect_to admin_posts_path
      end
    end

    context 'with invalid params' do
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

  describe 'GET edit' do
    before { set_admin_user }

    let(:blog_type) { Fabricate(:post_type, name: 'Blog') }

    it_behaves_like 'require admin' do
      let(:action) { delete :destroy, id: 1 }
    end

    it 'assigns @post' do
      post = Fabricate(:post, post_type: blog_type)
      get :edit, id: post.id
      expect(assigns(:post)).to eq(post)
    end

    it 'renders the edit template' do
      post = Fabricate(:post, post_type: blog_type)
      get :edit, id: post.id
      expect(response).to render_template :edit
    end
  end

  describe 'PATCH update' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { delete :destroy, id: 1 }
    end

    context 'with valid params' do
      let(:post) { Fabricate(:post) }

      it 'assigns @post' do
        patch :update, id: post.id, post: Fabricate.attributes_for(:post)
        expect(assigns(:post)).to be_instance_of(Post)
        expect(assigns(:post)).to eq(post.reload)
      end

      it 'assigns flash success message' do
        patch :update, id: post.id, post: Fabricate.attributes_for(:post)
        expect(flash[:success]).to be_present
      end

      it 'redirects to admin posts path' do
        patch :update, id: post.id, post: Fabricate.attributes_for(:post)
        expect(response).to redirect_to admin_posts_path
      end
    end

    context 'with invalid params' do
      it 'assigns Category.all to @categories' do
        post = Fabricate(:post)
        sports = Fabricate(:category, name: 'Sports')
        news = Fabricate(:category, name: 'News')
        patch :update, id: post.id, post: Fabricate.attributes_for(:post, title: '', category: sports)
        expect(assigns(:categories)).to eq([news, sports])
      end

      it 'assigns PostType.all to @post_types' do
        blog_type = Fabricate(:post_type, name: 'Blog')
        press_type = Fabricate(:post_type, name: 'Press')
        post = Fabricate(:post, post_type: blog_type)
        patch :update, id: post.id, post: Fabricate.attributes_for(:post, title: '', post_type: blog_type)
        expect(assigns(:post_types)).to eq([blog_type, press_type])
      end

      it 'renders the edit template' do
        post = Fabricate(:post)
        patch :update, id: post.id, post: Fabricate.attributes_for(:post, title: '')
        expect(response).to render_template :edit
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