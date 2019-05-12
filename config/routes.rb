

Rails.application.routes.draw do

  get '/', to: "welcomes#home"

  resources :books, only: [:index, :show, :new, :create] do
    resources :reviews, only: [:new, :create]
  end
  resources :reviews, only: [:destroy]

  resources :authors, only: :show
  resources :users, only: :show
end
