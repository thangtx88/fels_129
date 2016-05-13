Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  resources :categories, only: [:index, :new, :create]
  resources :lessons, except: [:index, :destroy, :edit]
  resources :words, only: :index
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

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
