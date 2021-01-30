Rails.application.routes.draw do
  devise_for :users
  root "tasks#index"

  namespace :tasks do
    resources :searches, only: :index
  end

  resources :tasks



end
