

Rails.application.routes.draw do

  root 'books#index'

  resources :books, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:destroy]

  resources :authors, only: :show
  resources :users, only: :show
end
