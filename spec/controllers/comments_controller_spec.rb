require 'spec_helper'

describe CommentsController do
  describe 'POST create' do
    let(:blog_type) { Fabricate(:post_type, name: 'Blog') }
    let(:blog_post) { Fabricate(:post, post_type: blog_type) }

    context 'with valid params' do
      let(:valid_comment_attributes) { Fabricate.attributes_for(:comment, post: blog_post) }
      before { post :create, blog_id: blog_post.id, comment: valid_comment_attributes }

      it 'saves a new comment' do
        expect(Comment.first.content).to eq(valid_comment_attributes[:content])
      end

      it 'sets flash success message' do
        expect(flash[:success]).to be_present
      end

      it 'redirects to the blog post path' do
        expect(response).to redirect_to blog_path(blog_post)
      end
    end

    context 'with invalid params' do
      let(:invalid_comment_attributes) { Fabricate.attributes_for(:comment, content: '') }

      it_behaves_like 'recent blog posts' do
        let(:action) { post :create, blog_id: 1, comment: invalid_comment_attributes }
      end

      it_behaves_like 'blog categories' do
        let(:action) { post :create, blog_id: blog_post.id, comment: invalid_comment_attributes }
      end

      it 'assigns @comments without invalid comment' do
        middle_comment = Fabricate(:comment, post: blog_post, created_at: Time.now-5)
        first_comment = Fabricate(:comment, post: blog_post, created_at: Time.now-10)
        post :create, blog_id: 1, comment: invalid_comment_attributes
        expect(assigns(:comments)).to eq([middle_comment, first_comment])
      end

      it 'assigns @comment' do
        post :create, blog_id: 1, comment: invalid_comment_attributes
        expect(assigns(:comment)).to be_instance_of Comment
        expect(assigns(:comment)).to be_new_record
      end

      it 'assigns @post' do
        post :create, blog_id: 1, comment: invalid_comment_attributes
        expect(assigns(:post)).to be_instance_of Post
      end

      it 'renders the blog show template' do
        post :create, blog_id: 1, comment: invalid_comment_attributes
        expect(response).to render_template 'blog/show'
      end
    end
  end
end