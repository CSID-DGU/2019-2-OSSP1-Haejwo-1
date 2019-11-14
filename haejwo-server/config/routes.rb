Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root 'events#index'
  get '/mypage' => 'users#mypage'

  resources :users, only: :update do
    collection do
      get :select_certification
      get :confirm_email
      post :submit_student_email
      post :check_email
      post :submit_student_card
    end
    member do
      post :token
    end
  end
  resources :events do
    post :check_valid, on: :collection
    resources :reports, only: [:new, :create]
  end

  post '/events/:id' => 'events#update'

  resources :maps, only: :index
  resources :notifications

  post '/tinymce_assets' => 'tinymce_assets#create'

  post '/events/perform/:id' => 'events#perform', as: :event_perform

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'

  resources :chatrooms do
    resources :messages, only: [:create, :destroy]
  end
  post '/chatroom_create' => 'chatrooms#create', as: :chatroom_create

  get '/reported_user' => 'users#reported_user'
  get '/waiting_user' => 'users#waiting_user'
end
