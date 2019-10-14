Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'events#index'
  get '/mypage' => 'users#mypage'

  resources :users, only: :update do
    collection do
      post :check_email
    end
    member do
      post :token
      get :token
    end
  end
  resources :events
  resources :maps, only: :index
  resources :notifications

  post '/tinymce_assets' => 'tinymce_assets#create'

  post '/events/perform/:id' => 'events#perform', as: :event_perform
end
