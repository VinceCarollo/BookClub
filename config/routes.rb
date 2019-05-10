Rails.application.routes.draw do
  resources :books, only: [:index, :show] do
    resources :reviews, only: [:new, :create]
  end

  resources :authors, only: :show
end
