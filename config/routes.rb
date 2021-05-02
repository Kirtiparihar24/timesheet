Rails.application.routes.draw do
  devise_for :users, path_prefix: 'admin'
  
  devise_scope :user do
    authenticated :user do
      root 'home#index', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resources :users do
    resources :time_entries do 
      resource :stop_timers, only: :update
    end
    resource :start_timers, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
