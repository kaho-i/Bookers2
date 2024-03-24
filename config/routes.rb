Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users
  resources :users, only: [:index, :show, :edit, :update]
  post 'users/:id' => 'books#create'
  post 'users/index' => 'books#create'
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy]
  get 'dashboard', to: 'application#dashboard'

  get "/home/about" => "homes#about", as: "about"
end
