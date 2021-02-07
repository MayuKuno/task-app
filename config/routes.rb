Rails.application.routes.draw do
  get 'notifications/index'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'
  root "tasks#index"

  namespace :admin do
    resources :users
  end

  resources :users, only: [:show]


  namespace :tasks do
    resources :searches, only: :index
  end

  resources :tasks do
    collection { post :import }
  end

  resources :groups do
    resources :tasks, only: [:index, :new, :create]
  end

  resources :notifications,only: [:index]


end
