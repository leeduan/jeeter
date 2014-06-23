require 'rails_helper'

describe PagesController do
  describe 'GET front_page' do
    it_behaves_like 'recent blog posts' do
      let(:action) { get :front_page }
    end

    it_behaves_like 'blog categories' do
      let(:action) { get :front_page }
    end

    it 'renders the front page template' do
      get :front_page
      expect(response).to render_template :front_page
    end
  end
end
