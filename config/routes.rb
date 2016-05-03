Rails.application.routes.draw do
  root "static_pages#home"
  get "sessions/new"
  get "signup"  => "users#new"
  get    "login"   => "sessions#new"
  post   "login"   => "sessions#create"
  delete "logout"  => "sessions#destroy"
  resources :users
  resources :categories, only: [:index, :new, :create]
  namespace :admin do
    root "categories#index"
    resources :users
    resources :categories
    resources :words, only: [:update, :destroy, :create]
  end
end
