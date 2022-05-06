Rails.application.routes.draw do
  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1 do
      resources :observations
      resources :doctors
      resources :patients
      resources :likes
      resources :comments
      resources :posts
      resources :friendships
      resources :device_data
      resources :devices
      resources :device_categories
      resources :users
    end
  end
end
