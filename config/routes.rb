Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  root to: 'static_pages#top'

  namespace :api do
    resources :posts, only: %i[index show create] do
      get :search, on: :collection
    end
    resources :postings, only: %i[index show update destroy]
    resources :likes, only: %i[index create destroy]
    get 'mylikes' => 'likes#show'

    resource :profiles, only: %i[] do
      get :mypage, on: :collection
      get '/:username', to: 'profiles#show'
    end
  end

  devise_for :admins, skip: %i[registrations password], controllers: {
    sessions: 'admins/sessions'
  }

  namespace :admins do
    root to: 'dashboards#index'
    resources :users
    resources :posts
  end

  get '*path', to: 'static_pages#top'
end
