

Rails.application.routes.draw do

  get '/', to: "welcomes#home"

  resources :books, only: [:index, :show, :new, :create, :destroy] do
    # resources :reviews, only: [:new, :create]
    get 'reviews/new', to: 'reviews#new'
    post 'reviews', to: 'reviews#create'
  end
  # resources :reviews, only: [:destroy]
  delete '/reviews/:id', to: 'reviews#destroy', as: 'review'

  # resources :authors, only: [:show, :destroy]
  get '/authors/:id', to: 'authors#show', as: 'author'
  delete '/authors/:id', to: 'authors#destroy'
  # resources :users, only: :show
  get '/users/:id', to: 'users#show', as: 'user'
end
