Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :players, only: [:new, :create, :destroy]
  resources :games, only: [:show, :create, :edit, :update, :destroy] do
    resources :questions, only: [:create]
  end
  resources :questions, only: [:show, :destroy] do
    member do
      get :waiting_room
    end
    resources :answers, only: [:index, :create]
  end
  resources :answers, only: [:show] do
    resources :votes, only: [:create]
  end
end
