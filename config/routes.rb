

Rails.application.routes.draw do

  root 'books#index'

  resources :books, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
  end

  resources :authors, only: :show
end
