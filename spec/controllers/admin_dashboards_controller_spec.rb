require 'spec_helper'

describe Admin::DashboardsController do
  describe 'GET index' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { get :index }
    end

    it_behaves_like 'recent blog posts' do
      let(:action) { get :index }
    end

    it_behaves_like 'recent comments' do
      let(:action) { get :index }
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end
end
