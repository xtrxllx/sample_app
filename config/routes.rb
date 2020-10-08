Rails.application.routes.draw do
  root "chapter3#home"

  get "/home", to: "chapter3#home"
  resources :users
  resources :account_activations, only: :edit
  resources :password_resets, except: %i(show index destroy)
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
