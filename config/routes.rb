Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      sessions: "users/sessions",
      registrations: "users/registrations",
    }

  root "home#index"
  get "/member-data", to: "members#show"
  # Defines the root path route ("/")
  # root "articles#index"
  namespace :api do
    namespace :v1, defaults: { format: :json } do
      get "device_data/show_avg_hourly_data" => "device_data#show_avg_hourly_data"
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
      resources :users do
        get 'posts', to: 'users#posts'
      end
    end
  end
end
