Rails.application.routes.draw do
  root 'posts#index'
  resources :posts do
    resources :comments, only: %i[create destroy]
  end
  devise_for :users
  resources :users, only: %i[index show]
  resources :users do
    member do
      get :followed
    end
  end
  resources :followers, only: %i[create destroy]
  resources :favorites, only: %i[create destroy]
end
