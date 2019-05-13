

Rails.application.routes.draw do

  get '/', to: "welcomes#home"

  resources :books, only: [:index, :show, :new, :create, :destroy] do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:destroy]

  resources :authors, only: [:show, :destroy]
  resources :users, only: :show
end
