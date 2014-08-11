require 'rails_helper'

describe Admin::SessionsController do
  describe 'GET index' do

    context 'user is already signed in' do
      it 'redirects to admin dashboard' do
        admin = Fabricate(:admin, password: 'admin')
        session[:user_id] = admin.id
        get :index
        expect(response).to redirect_to admin_path
      end
    end

    context 'user is not signed in' do
      it 'renders the index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe 'POST create' do
    let!(:admin) { Fabricate(:admin, password: 'admin') }

    context 'valid params' do
      before { post :create, username: admin.username, password: 'admin' }
      it 'sets session id' do
        expect(session[:user_id]).to eq(admin.id)
      end

      it 'redirects to admin dashboard' do
        expect(response).to redirect_to admin_path
      end
    end

    context 'invalid params' do
      before { post :create }

      it 'assigns flash danger now message' do
        expect(flash.now[:danger]).to be_present
      end

      it 'renders the index template' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'GET destroy' do
    let!(:admin) { Fabricate(:admin, password: 'admin') }

    before do
      session[:user_id] = admin.id
      get :destroy
    end

    it 'deletes the user session' do
      expect(session[:user_id]).to eq(nil)
    end

    it 'assigns flash message' do
      expect(flash[:success]).to be_present
    end

    it 'redirects to root path' do
      expect(response).to redirect_to root_path
    end
  end
end
