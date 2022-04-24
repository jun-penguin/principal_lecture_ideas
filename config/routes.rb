Rails.application.routes.draw do
  root to: 'static_pages#top'
  resources :posts, only: [:index]

  namespace :api do
    resources :posts, only: [:index, :show]
  end
end
