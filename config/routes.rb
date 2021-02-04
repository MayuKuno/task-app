Rails.application.routes.draw do
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'

  namespace :admin do
    resources :users
  end
  root "tasks#index"
  resources :users, only: [:show]

  namespace :tasks do
    resources :searches, only: :index
  end
  resources :tasks do
    collection { post :import }
  end

end
