Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  resources :users, only: [:create, :index, :show, :edit, :update]
  get 'dashboard', to: 'application#dashboard'
  
  get "/homes/about" => "homes#about", as: "about"
end
