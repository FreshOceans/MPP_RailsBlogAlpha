Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # == custom routes
  # get "/" => "home#home"
  get "/" => "users#home"
  get "/login_form" => "users#login_form"
  post "/login" => "users#login"
  get "/logout" => "users#logout"

  # == RESTful routes
  resources :tags
  # resources :post_tags

  resources :users do
      resources :posts
      resources :comments
  end


end
