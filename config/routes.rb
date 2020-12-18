Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :players, only: [:new, :create, :destroy]
  resources :games, only: [:show, :create, :edit, :update, :destroy] do
    resources :questions, only: [:create]
    member do
      get :summary
    end
  end
  resources :questions, only: [:show, :destroy] do
    resources :answers, only: [:index, :create]
  end
  resources :answers, only: [:show] do
    resources :votes, only: [:create, :index]
  end
end
