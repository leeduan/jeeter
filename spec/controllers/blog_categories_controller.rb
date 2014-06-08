require 'spec_helper'

describe Blog::CategoriesController do
  describe 'GET show' do
    let(:blog_type) { Fabricate(:post_type, name: 'Blog') }
    let(:category) { Fabricate(:category) }
    let(:user) { Fabricate(:user) }

    it_behaves_like 'recent blog posts' do
      let(:action) { get :show, id: category.id }
    end

    it_behaves_like 'blog categories' do
      let(:action) { get :show, id: category.id }
    end

    it 'assigns users @posts' do
      other_category = Fabricate(:category)
      porsche_cayenne = Fabricate(:post, category: other_category, post_type: blog_type, title: 'Porsche Cayenne')
      bmw_x5 = Fabricate(:post, category: category, post_type: blog_type, title: 'BMW X5', published_at: Time.now - 10)
      mercedes_ml = Fabricate(:post, category: category, post_type: blog_type, title: 'Mercedes ML')
      get :show, id: category.id
      expect(assigns(:posts)).to eq([mercedes_ml, bmw_x5])
    end

    it 'renders the show template' do
      get :show, id: category.id
      expect(response).to render_template :show
    end
  end
end