Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # namespace :rails do
  #   resources :books
  # end

  # scope :rails do
  #   resources :books
  # end

  # resources :books, path: '/rails/books'

  # shallow do 
  #   resources :books
  # end

  # scope shallow_path: "sekret" do
  #   resources :books , shallow: true
  # end

  
end
