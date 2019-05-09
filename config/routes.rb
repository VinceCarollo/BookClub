Rails.application.routes.draw do
  resources :books, only: [:index, :show]
  resources :authors, only: :show
end
