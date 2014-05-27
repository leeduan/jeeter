require 'spec_helper'

describe Admin::CategoriesController do
  describe 'POST create' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { post :create }
    end

    context 'JSON response' do
      it 'responds with category created if name is valid' do
        category_attributes = Fabricate.attributes_for(:category, name: 'News')
        post :create, category: category_attributes, format: :json
        expect(JSON.parse(response.body)['name']).to eq(category_attributes[:name])
      end

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
end