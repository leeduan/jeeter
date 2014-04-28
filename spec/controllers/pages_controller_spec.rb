require 'spec_helper'

describe PagesController do
  describe 'GET front_page' do
    it 'renders the front page template' do
      get :front_page
      expect(response).to render_template :front_page
    end
  end
end
