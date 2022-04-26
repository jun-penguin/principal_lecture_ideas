Rails.application.routes.draw do
  root to: 'static_pages#top'
  get '/post/:id', to: 'static_pages#top'

  namespace :api do
    resources :posts, only: [:index, :show]
  end
end
