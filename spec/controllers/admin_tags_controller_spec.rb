require 'rails_helper'

describe Admin::TagsController do
  describe 'GET index' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { get :index }
    end

    it 'assigns @search_term' do
      get :index, search_term: 'hello'
      expect(assigns(:search_term)).to eq('hello')
    end

    it 'assigns @tag' do
      get :index
      expect(assigns(:tag)).to be_instance_of Tag
      expect(assigns(:tag)).to be_new_record
    end

    it 'assigns @tags' do
      news = Fabricate(:tag, name: 'News')
      sports = Fabricate(:tag, name: 'Sports')
      get :index
      expect(assigns(:tags)).to eq([news, sports])
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
      it 'responds with tags created if name is valid' do
        xhr :post, :create, new_tag: 'tips, advice', format: :json
        expect(JSON.parse(response.body)[0]['name']).to eq('tips')
        expect(JSON.parse(response.body)[1]['name']).to eq('advice')
      end

      it 'response with error if no valid tags' do
        xhr :post, :create, new_tag: ' ', format: :json
        expect(JSON.parse(response.body)['name']).to eq('no valid tags')
      end
    end

    context 'HTML response' do
      it 'assigns flash success if valid params' do
        tag_attributes = Fabricate.attributes_for(:tag, name: 'News')
        post :create, tag: tag_attributes
        expect(flash[:success]).to be_present
      end

      it 'assigns flash error if invalid params' do
        tag_attributes = Fabricate.attributes_for(:tag, name: '')
        post :create, tag: tag_attributes
        expect(flash[:danger]).to be_present
      end

      it 'redirects to admin tags path' do
        tag_attributes = Fabricate.attributes_for(:tag, name: '')
        post :create, tag: tag_attributes
        expect(response).to redirect_to admin_tags_path
      end
    end
  end

  describe 'PUT update' do
    before { set_admin_user }
    let(:tag) { Fabricate(:tag, name: 'Advice') }

    it_behaves_like 'require admin' do
      let(:action) { put :update, id: tag.id }
    end

    context 'valid params' do
      before do
        tag_attributes = Fabricate.attributes_for(:tag, name: 'Support')
        put :update, id: tag.id, tag: tag_attributes
      end

      it 'sets flash success' do
        expect(flash[:success]).to be_present
      end

      it 'updates the tag' do
        expect(tag.reload.name).to eq('Support')
      end

      it 'redirects to admin categories path' do
        expect(response).to redirect_to admin_tags_path
      end
    end

    context 'invalid params' do
      before do
        tag_attributes = Fabricate.attributes_for(:tag, name: '')
        put :update, id: tag.id, tag: tag_attributes
      end

      it 'assigns @tag' do
        expect(flash[:danger]).to be_present
      end

      it 'does not update the tag' do
        expect(tag.name).to eq('Advice')
      end

      it 'renders the edit template' do
        expect(response).to render_template :edit
      end
    end
  end
end