Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/new'
    get 'users/show'
    get 'users/edit'
    get 'users/update'
    get 'users/destroy'
  end
  namespace :admin do
    get 'dashboards/index'
  end
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

  namespace :admin do
    root to: 'dashboards#index'
    resources :users
  end

  get '*path', to: 'static_pages#top'
end
