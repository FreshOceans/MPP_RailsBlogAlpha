Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # route format for customized controllers with devise functionality
  # devise_for :users, :controllers => { registrations: 'registrations' }

  # == devise routes
  devise_for :users

  # == custom routes
  # get "/" => "home#home"
  root to: "users#home"
  get "/feed" => "users#feed"
  # get "/login_form" => "users#login_form"
  # post "/login" => "users#login"
  # get "/logout" => "users#logout"



  # == RESTful routes
  resources :users do
      resources :posts
      resources :comments
      resources :addresses
  end
  # resources :tags
  # resources :post_tags

end
