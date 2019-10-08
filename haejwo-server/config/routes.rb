Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'events#index'
  devise_for :users
  get '/mypage' => 'users#mypage'

  resources :users, only: :update
  resources :events
  resources :maps, only: :index
  resources :notifications

  post '/tinymce_assets' => 'tinymce_assets#create'

  post '/events/perform/:id' => 'events#perform', as: :event_perform
end
