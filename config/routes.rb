Rails.application.routes.draw do
  root to: "static_pages#home"

  resource :registration, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :account_activations, only: [:edit]

  resources :categories, except: [:show]
  resources :products, except: [:index]

  resource :order, only: [:show, :update] do
    resource :payment_result, only: [:show]
  end

  resources :order_items, only: [:create, :update, :destroy]

  resources :stock_items, except: [:show]
  resources :stock_movements, except: [:show]

  namespace :manager do
    resources :shifts, only: [:index]

    resources :users, only: [] do
      resources :shifts, except: [:index, :show], shallow: true
    end
  end
end
