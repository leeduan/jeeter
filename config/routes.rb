Railspress::Application.routes.draw do
  root to: 'pages', action: :front_page
  get '/front', to: 'pages', action: :front_page
  get '/blog', to: 'blog_posts', action: :index

  namespace :admin do
    get '/login', to: 'sessions#index'
    post '/login', to: 'sessions#create'
    get '/', to: 'dashboards#index'

    resources :posts, only: [:index, :destroy]
  end
end
