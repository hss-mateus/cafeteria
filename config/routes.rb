Rails.application.routes.draw do
  root to: "static_pages#home"

  resource :registration, only: [:new, :create, :edit, :update]
  resource :session, only: [:new, :create, :destroy]
  resources :account_activations, only: [:edit]

  resources :categories, except: [:show]
  resources :products, except: [:index] do
    resources :ratings, only: [:create]
  end

  resources :orders, only: [:index, :show, :update] do
    resource :payment_result, only: [:show]
  end

  resource :order, as: :current_order, only: [:show]

  resources :order_items, only: [:create, :destroy]

  namespace :manager do
    resources :shifts, only: [:index]
    resources :statistics, only: [:index]
    resources :sales, except: [:show]
    resources :stock_items, except: [:show]
    resources :stock_movements, except: [:show]

    resources :users, only: [] do
      resources :shifts, except: [:index, :show], shallow: true
    end
  end

  namespace :employee do
    resources :shifts, only: [:index]
    resources :table_reservations, only: [:index, :edit, :update, :destroy]

    resources :users, only: [:index] do
      resources :messages, only: [:index, :create]
    end
  end

  resources :table_reservations, only: [:index, :new, :create, :destroy]
end
