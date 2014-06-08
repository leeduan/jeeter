require 'spec_helper'

describe Blog::UsersController do
  describe 'GET show' do
    let(:blog_type) { Fabricate(:post_type, name: 'Blog') }
    let(:user) { Fabricate(:user) }

    it_behaves_like 'recent blog posts' do
      let(:action) { get :show, id: user.id }
    end

    it_behaves_like 'blog categories' do
      let(:action) { get :show, id: user.id }
    end

    it 'assigns users @posts' do
      other_user = Fabricate(:user)
      porsche_cayenne = Fabricate(:post, user: other_user, post_type: blog_type, title: 'Porsche Cayenne')
      bmw_x5 = Fabricate(:post, user: user, post_type: blog_type, title: 'BMW X5', published_at: Time.now - 10)
      mercedes_ml = Fabricate(:post, user: user, post_type: blog_type, title: 'Mercedes ML')
      get :show, id: user.id
      expect(assigns(:posts)).to eq([mercedes_ml, bmw_x5])
    end

    it 'renders the show template' do
      get :show, id: user.id
      expect(response).to render_template :show
    end
  end
end