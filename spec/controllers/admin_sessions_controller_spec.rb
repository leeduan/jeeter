require 'rails_helper'

describe Admin::SessionsController do
  describe 'GET index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'POST create' do
    let!(:admin) { Fabricate(:admin, password: 'admin') }

    context 'valid params' do
      it 'sets session id' do
        post :create, username: admin.username, password: 'admin'
        expect(session[:user_id]).to eq(admin.id)
      end

      it 'redirects to admin dashboard' do
        post :create, username: admin.username, password: 'admin'
        expect(response).to redirect_to admin_path
      end
    end

    context 'invalid params' do
      it 'renders the index template' do
        post :create
        expect(response).to render_template :index
      end
    end
  end
end
