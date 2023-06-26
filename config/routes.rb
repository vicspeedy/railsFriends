Rails.application.routes.draw do
  #delete 'users/sign_out'

  devise_for :users
  resources :friends
  get 'home/index'
  get 'home/about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root "home#index"
  root "friends#index"
end
