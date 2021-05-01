Rails.application.routes.draw do
  root 'home#index'
  devise_for :users
  resources :users do
    resources :time_entries do 
      resource :stop_timers, only: :update
    end
    resource :start_timers, only: :create
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
