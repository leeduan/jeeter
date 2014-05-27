require 'spec_helper'

describe Admin::TagsController do
  describe 'POST create' do
    before { set_admin_user }

    it_behaves_like 'require admin' do
      let(:action) { post :create }
    end

    context 'JSON response' do
      it 'responds with tag created if name is valid' do
        post :create, new_tag: 'tips, advice', format: :json
        expect(JSON.parse(response.body)[0]['name']).to eq('tips')
        expect(JSON.parse(response.body)[1]['name']).to eq('advice')
      end

      it 'response with error if no valid tags' do
        post :create, new_tag: ' ', format: :json
        expect(JSON.parse(response.body)['name']).to eq('no valid tags')
      end
    end
  end
end