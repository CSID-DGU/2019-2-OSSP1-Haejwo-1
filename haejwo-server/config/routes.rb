Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'events#index'
  get '/mypage' => 'users#mypage'

  resources :users, only: :update do
    collection do
      get :select_certification
      post :check_email
    end
    member do
      post :token
    end
  end
  resources :events
  resources :maps, only: :index
  resources :notifications

  post '/tinymce_assets' => 'tinymce_assets#create'

  post '/events/perform/:id' => 'events#perform', as: :event_perform

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :chatrooms
  resources :messages
end
