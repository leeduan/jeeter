require 'rails_helper'

describe Admin::CommentsController do
  before { set_admin_user }

  describe 'GET index' do
    it_behaves_like 'require admin' do
      let(:action) { get :index }
    end

    it 'assigns @search_term' do
      get :index, search_term: 'hello'
      expect(assigns(:search_term)).to eq('hello')
    end

    it 'assigns @comments' do
      positive_comment = Fabricate(:comment, content: 'Very informative post!')
      negative_comment = Fabricate(:comment, content: 'I dont like your face.', created_at: Time.now - 5)
      get :index, search_term: ''
      expect(assigns(:comments)).to eq([positive_comment, negative_comment])
    end

    it 'renders the index path' do
      get :index, search_term: ''
      expect(response).to render_template :index
    end
  end

  describe 'POST approve' do
    it_behaves_like 'require admin' do
      let(:action) { get :index }
    end

    context 'HTML response' do
      it 'redirects to admin_comments_path' do
        post :approve, id: 1, approved: "true"
        expect(response).to redirect_to admin_comments_path
      end
    end

    context 'JSON response' do
      let(:comment) { Fabricate(:comment) }

      it 'assigns @comment' do
        xhr :post, :approve, id: comment.id, approved: "true", format: :json
        expect(assigns(:comment)).to eq(comment);
      end

      context 'with valid params' do
        it 'saves approved to be true if param passed is true' do
          xhr :post, :approve, id: comment.id, approved: "true", format: :json
          expect(comment.reload.approved).to eq(true)
        end

        it 'saves approved to be false if param passed is false' do
          xhr :post, :approve, id: comment.id, approved: "false", format: :json
          expect(comment.reload.approved).to eq(false)
        end

        it 'responds with comment json object' do
          xhr :post, :approve, id: comment.id, approved: "true", format: :json
          expect(JSON.parse(response.body)['approved']).to eq(true)
        end
      end

      context 'with invalid params' do
        it 'responds with url json object' do
          xhr :post, :approve, id: comment.id, approved: 'asdfg', format: :json
          expect(JSON.parse(response.body)['url']).to eq('/admin/comments')
        end
      end
    end
  end
end