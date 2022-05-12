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
  end

  get '*path', to: 'static_pages#top'
end
