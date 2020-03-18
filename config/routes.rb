Rails.application.routes.draw do
  resources :articles
  root 'articles#index'
  resources :articles
end
