Rails.application.routes.draw do
  resources :friendships
  resources :device_data
  resources :devices
  resources :device_categories
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      
    end
  end
end
