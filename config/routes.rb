Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    registrations: 'auth/registrations'
  }
  root to: 'static_pages#top'
  get '/post/:id', to: 'static_pages#top'

  namespace :api do
    resources :posts, only: [:index, :show]
  end
end
