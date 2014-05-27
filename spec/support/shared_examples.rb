shared_examples 'recent blog posts' do
  it 'assigns five @recent_posts in desc order' do
    decrement_time = 0
    time_interval = 5
    blog_type = Fabricate(:post_type, name: 'Blog')

    6.times do
      Fabricate(:post, post_type: blog_type, published_at: Time.now - decrement_time)
      decrement_time -= time_interval
    end

    action
    expect(assigns(:recent_posts)).to eq(Post.last(5).reverse)
  end
end

shared_examples 'blog categories' do
  it 'assigns five @categories in asc name order' do
    str = 'z'

    6.times do |i|
      Fabricate(:category, name: str)
      str = (str.ord - 1).chr
    end

    action
    expect(assigns(:categories)).to eq(Category.last(5).reverse)
  end
end

shared_examples 'require admin' do
  it 'redirects the user to root path if not admin' do
    clear_current_user
    user = Fabricate(:user)
    session[:user_id] = user.id
    action
    expect(response).to redirect_to root_path
  end
end
