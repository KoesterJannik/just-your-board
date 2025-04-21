Rails.application.routes.draw do
  get "invitation/accept/:token" => "invitation#accept", as: :accept_invitation
  resources :cards
  resources :columns
  resources :boards
  resource :session
  resources :passwords, param: :token
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "dashboard" => "dashboard#index", as: :dashboard
  get "register" => "home#register"
  post "register" => "home#create_account"
  root "home#index"
  resources :boards do
    get "invitation/new"
    post "invitation/create"

    resources :columns do
      resources :cards
    end
  end

  post "update_card_positions" => "cards#update_positions", as: :update_card_positions

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
