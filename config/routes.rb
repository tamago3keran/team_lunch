Rails.application.routes.draw do
  root to: "lunches#index"
  resources :lunches, only: [:index, :show, :new, :create, :destroy] do
    scope module: :lunches do
      resource :applied_status, only: [:update]
      resources :groups, only: [:new, :create, :edit, :update, :destroy]
    end
  end
  resource :office, only: [:show, :new, :create, :edit, :update]
  resources :restaurants, only: [] do
    resource :bulk_create, only: [:create]
  end
  resources :users, only: [:index, :new, :create] do
    scope module: :users do
      resource :activation, only: [:update, :destroy]
    end
  end
end
