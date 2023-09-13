Rails.application.routes.draw do
  root to: "static_pages#home"

  resource :registration, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :account_activations, only: [:edit]
end
