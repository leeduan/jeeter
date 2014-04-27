Railspress::Application.routes.draw do
  root to: 'pages#front_page'
  get '/front', to: 'pages#front_page'
end
