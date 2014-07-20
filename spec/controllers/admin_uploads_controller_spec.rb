require 'rails_helper'

describe Admin::UploadsController do
  before { set_admin_user }

  describe 'GET index' do
    it_behaves_like 'require admin' do
      let(:action) { get :index }
    end

    it 'assigns search_terms' do
      get :index, search_term: 'hello'
      expect(assigns(:search_term)).to eq('hello')
    end

    it 'assigns uploads' do
      js_upload = ActionDispatch::Http::UploadedFile.new({
        filename: 'hello-world2a9e6fa92d2589e7b07f9b2ac6eadca1.js',
        type: 'application/javascript',
        tempfile: File.new("#{Rails.root}/spec/fixtures/applications/hello-world2a9e6fa92d2589e7b07f9b2ac6eadca1.js")
      })
      image = Fabricate(:upload, created_at: Time.now)
      js = Fabricate(:upload, media: js_upload, created_at: Time.now - 10)

      get :index
      expect(assigns(:uploads)).to eq([image, js])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET new' do
    it_behaves_like 'require admin' do
      let(:action) { get :new }
    end

    it 'assigns @upload' do
      get :new
      expect(assigns(:upload)).to be_instance_of Upload
      expect(assigns(:upload)).to be_new_record
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST create' do
    it_behaves_like 'require admin' do
      let(:action) { get :new }
    end

    context 'JSON response' do
      context 'with valid params' do
        it 'responds with upload created' do
          xhr :post, :create, upload: Fabricate.attributes_for(:upload), format: :json
          expect(JSON.parse(response.body)['media_file_name']).to eq('placeholder3d15e3a5eaae04842667502103f994d8.gif')
          expect(JSON.parse(response.body)['media_content_type']).to eq('image/gif')
        end
      end

      context 'with invalid params' do
        let(:invalid_params) { Fabricate.attributes_for(:upload, media: nil) }

        it 'responds with errors' do
          xhr :post, :create, upload: invalid_params, format: :json
          expect(JSON.parse(response.body)['media'].any?).to eq(true)
        end
      end
    end

    context 'HTML response' do
      context 'with valid params' do
        let(:valid_params) { Fabricate.attributes_for(:upload) }

        it 'saves a new upload' do
          post :create, upload: valid_params
          expect(Upload.first.media_file_name).to eq('placeholder3d15e3a5eaae04842667502103f994d8.gif')
        end

        it 'assigns flash success message' do
          post :create, upload: valid_params
          expect(flash[:success]).to be_present
        end

        it 'redirects to new admin uploads path' do
          post :create, upload: valid_params
          expect(response).to redirect_to new_admin_upload_path
        end
      end

      context 'with invalid params' do
        let(:invalid_params) { Fabricate.attributes_for(:upload, media: nil) }

        it 'does not save a new upload' do
          post :create, upload: invalid_params
          expect(Upload.all.size).to eq(0)
        end

        it 'assigns @upload' do
          post :create, upload: invalid_params
          expect(assigns(:upload)).to be_instance_of Upload
        end

        it 'assigns flash danger message' do
          post :create, upload: invalid_params
          expect(flash.now[:danger]).to be_present
        end

        it 'renders the new template' do
          post :create, upload: invalid_params
          expect(response).to render_template :new
        end
      end
    end
  end

  describe 'GET edit' do
    it_behaves_like 'require admin' do
      let(:action) { get :edit, id: 1 }
    end

    let(:upload) { Fabricate(:upload) }

    it 'assigns @upload' do
      get :edit, id: upload.to_param
      expect(assigns(:upload)).to eq(upload);
    end

    it 'renders the edit template' do
      get :edit, id: upload.to_param
      expect(response).to render_template :edit
    end
  end

  describe 'DELETE destroy' do
    let(:upload) { Fabricate(:upload) }

    it_behaves_like 'require admin' do
      let(:action) { delete :destroy, id: upload.to_param }
    end

    it 'deletes the upload and file' do
      delete :destroy, id: upload.to_param
      expect(Upload.count).to eq(0)
      expect(File.exists? "#{Rails.root}/spec/test_files/placeholder3d15e3a5eaae04842667502103f994d8.gif").to eq(false)
    end

    it 'assigns flash success message' do
      delete :destroy, id: upload.to_param
      expect(flash[:success]).to be_present
    end

    it 'redirects to admin uploads path' do
      delete :destroy, id: upload.to_param
      expect(response).to redirect_to admin_uploads_path
    end
  end

  describe 'PATCH update' do
    let(:upload) { Fabricate(:upload) }

    it_behaves_like 'require admin' do
      let(:action) { patch :update, id: upload.to_param }
    end

    context 'with valid params' do
      before { patch :update, upload: { alt: 'Derek', description: 'Derek Card' }, id: upload.to_param }

      it 'updates the description and alt text' do
        upload = Upload.first
        expect(upload.alt).to eq('Derek')
        expect(upload.description).to eq('Derek Card')
      end

      it 'assigns flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to edit upload path' do
        expect(response).to redirect_to edit_admin_upload_path(upload)
      end
    end

    context 'with invalid params' do
      too_long_text = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas posuere ' +
                      'auctor ornare. Pellentesque augue risus, sollicitudin a rutrum eget, ultricies ' +
                      'vel metus. Sed facilisis aliquet lobortis. Ut scelerisque auctor erat, eu ' +
                      'dapibus nisi pulvinar ut. Fusce iaculis mi id lorem posuere, quis scelerisque ' +
                      'lorem porttitor. Vestibulum porta, diam in suscipit venenatis, erat nibh bibendum ' +
                      'justo, id ultricies purus sapien id tortor. Aliquam sit amet mi viverra, ultricies ' +
                      'nisl et, lacinia erat. Mauris vel nisl eros. Morbi magna magna, vulputate vitae ' +
                      'malesuada nec, scelerisque sed felis. Sed vestibulum metus ut auctor lacinia. ' +
                      'Fusce elementum leo nisl, tincidunt porta erat dictum id. Aenean euismod tortor ' +
                      'lacinia, scelerisque diam sed, faucibus tortor.'
      before { patch :update, upload: { alt: too_long_text, description: '' }, id: upload.to_param }

      it 'assigns flash danger now message' do
        expect(flash.now[:danger]).to be_present
      end

      it 'renders the edit upload path' do
        expect(response).to render_template :edit
      end
    end
  end
end