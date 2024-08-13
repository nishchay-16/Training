Rails.application.routes.draw do
  devise_for :users
  resources :customers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root 'customers#index'
  get 'payments/new', to: 'payments#new', as: 'new_payment'
  post 'payments/one_time_payment', to: 'payments#one_time_payment', as: 'one_time_payment'
  post 'payments/recurring_payment', to: 'payments#recurring_payment', as: 'recurring_payment'
  get 'payments/success', to: 'payments#success', as: 'success'
  get 'payments/index', to: 'payments#index', as: 'subscriptions'
  get 'payments/payment_index', to: 'payments#payment_index', as: 'charges'

  get '/create_product', to: 'payments#create_product'
end
