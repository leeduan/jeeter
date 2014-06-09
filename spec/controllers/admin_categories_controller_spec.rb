require 'spec_helper'

describe Admin::CategoriesController do
  describe 'GET index' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { post :create }
    end

    it 'assigns @search_term' do
      get :index, search_term: 'hello'
      expect(assigns(:search_term)).to eq('hello')
    end

    it 'assigns @category' do
      get :index
      expect(assigns(:category)).to be_instance_of Category
      expect(assigns(:category)).to be_new_record
    end

    it 'assigns @categories' do
      news = Fabricate(:category, name: 'News')
      sports = Fabricate(:category, name: 'Sports')
      get :index
      expect(assigns(:categories)).to eq([news, sports])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST create' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { post :create }
    end

    context 'JSON response' do
      context 'valid category params' do
        it 'responds with category created' do
          category_attributes = Fabricate.attributes_for(:category, name: 'News')
          post :create, category: category_attributes, format: :json
          expect(JSON.parse(response.body)['name']).to eq(category_attributes[:name])
        end
      end

      context 'invalid category params' do
        it 'response with error of has been taken if category exists' do
          Fabricate(:category, name: 'News')
          category_attributes = Fabricate.attributes_for(:category, name: 'News')
          post :create, category: category_attributes, format: :json
          expect(JSON.parse(response.body)['name']).to eq(["has already been taken"])
        end

        it 'responds with error of cant be blank if empty string' do
          category_attributes = Fabricate.attributes_for(:category, name: '')
          post :create, category: category_attributes, format: :json
          expect(JSON.parse(response.body)['name']).to eq(["can't be blank"])
        end
      end
    end

    context 'HTML response' do
      it 'assigns flash success if valid params' do
        category_attributes = Fabricate.attributes_for(:category, name: 'News')
        post :create, category: category_attributes
        expect(flash[:success]).to be_present
      end

      it 'assigns flash error if invalid params' do
        category_attributes = Fabricate.attributes_for(:category, name: '')
        post :create, category: category_attributes
        expect(flash[:danger]).to be_present
      end

      it 'redirects to admin categories path' do
        category_attributes = Fabricate.attributes_for(:category, name: '')
        post :create, category: category_attributes
        expect(response).to redirect_to admin_categories_path
      end
    end
  end
end