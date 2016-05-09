Rails.application.routes.draw do
  root "static_pages#home"
  get "sessions/new"
  get "signup"  => "users#new"
  get    "login"   => "sessions#new"
  post   "login"   => "sessions#create"
  delete "logout"  => "sessions#destroy"

  resources :categories, only: [:index, :new, :create]
  resources :lessons, except: [:index, :destroy, :edit]
  resources :words, only: :index
  resources :sessions, only: [:new, :create]
  resources :relationships, only: [:index, :create, :destroy]

  resources :users do
    get "/:relationship" => "relationships#index", as: :relationship,
      constraints: {relationship: /(following|followers)/}
  end

  namespace :admin do
    root "categories#index"
    resources :users
    resources :categories
    resources :words, only: [:update, :destroy, :create]
  end
end
