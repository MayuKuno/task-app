Rails.application.routes.draw do
  get 'tasks/calendar'
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
    resources :searches, only: :index, defaults: { format: :json } do
      put :sort
    end
  end

  resources :tasks do
    put :sort
    post :import, on: :collection
  end

  resources :groups do
    resources :tasks
    post :import, on: :collection

  end

  resources :notifications,only: [:index]


end
