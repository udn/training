Rails.application.routes.draw do
  root 'articles#index'
  resources :articles

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
