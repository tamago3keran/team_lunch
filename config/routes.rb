Rails.application.routes.draw do
  root to: "lunches#index"
  resources :users, only: [:index, :new, :create] do
    scope module: :users do
      resource :activation, only: [:update, :destroy]
    end
  end
  resource :office, only: [:show, :new, :create]
  resources :lunches, only: [:index, :show, :new, :create, :destroy] do
    scope module: :lunches do
      resources :groups, only: [:new, :create, :edit, :update, :destroy]
      resource :applied_status, only: [:update]
    end
  end
end
