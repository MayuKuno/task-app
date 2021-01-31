Rails.application.routes.draw do
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to:'sessions#destroy'

  namespace :admin do
    resources :users
  end
  root "tasks#index"
  resources :users, only: [:show]

  resources :tasks do
    collection do
      get 'search'
    end
  end



  # namespace :tasks do
  #   resources :searches, only: :index
  # end
end
