Rails.application.routes.draw do
  resources :books, only: [:index, :show] do
    resources :reviews, only: [:new]
  end

  resources :authors, only: :show
end
