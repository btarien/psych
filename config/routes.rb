Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :games, only: [:show, :create, :edit, :update, :destroy]
  resources :players, only: [:new, :create, :destroy]
  resources :questions, only: [:show, :create]
  resources :answers, only: [:index, :create]
  resources :votes, only: [:create]
end
