Railspress::Application.routes.draw do
  root to: 'pages', action: :front_page
  get '/front', to: 'pages', action: :front_page
  get '/blog', to: 'blog_posts', action: :index
end
