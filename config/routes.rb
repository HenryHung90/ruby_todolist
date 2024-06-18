Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/h5xredu/admin', to: 'page#admin'
  resources :users do
    resources :tasks, except: [:index]
  end
  namespace :admin, path: "5xrhendo" do
    resources :manage_tasks
    resources :manage_users
  end
  # Defines the root path route ("/")
  root "page#index"
end
