# == Route Map
#

Rails.application.routes.draw do
  root to: 'static_pages#top'
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'api/v1/auth/registrations',
    sessions: 'api/v1/auth/sessions'
  }
  devise_scope :user do
    post 'auth/guest_sign_in', to: 'api/v1/auth/sessions#guest_sign_in'
  end
  namespace :api do
    namespace :v1 do
      # mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      #   registrations: 'api/v1/auth/registrations'
      # }
      resources :posts, only: %i[index show create] do
        get :search, on: :collection
      end
      resources :postings, only: %i[index show update destroy]
      resources :likes, only: %i[index create destroy]
      get 'mylikes' => 'likes#show'
      resources :comments, only: %i[index create update destroy]
      resource :profiles, only: %i[] do
        get :mypage, on: :collection
        get '/:username', to: 'profiles#show'
      end
      # devise_scope :user do
      #   post 'auth/guest_sign_in', to: 'auth/sessions#guest_sign_in'
      # end
    end
  end

  devise_for :admins, skip: %i[registrations passoword], controllers: {
    sessions: 'admins/sessions'
    # passwords: 'admins/passwords',
    # registrations: 'admins/registrations'
  }

  namespace :admins do
    root to: 'dashboards#index'
    resources :users
    resources :posts
    resources :comments
  end

  get '*path', to: 'static_pages#top'
end
