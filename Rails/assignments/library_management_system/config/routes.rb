Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "books#index"

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

  # resources :books do
  #   member do
  #     get 'preview' => 'books#show'
  #   end
  # end

  # resources :books do
  #   get 'preview', on: :member
  # end

  # resources :books
  # resolve ("copy") {[:books]}

  # scope(path_names: { new: 'neu', edit: 'bearbeiten' }) do
  #   resources :books, path: 'bookies'
  # end
  
  direct :homepage do
    "https://rubyonrails.org"
  end  

  resources :books
  
  # resources :books do
  #   collection do
  #     get 'preview' => 'books#index'
  #   end
  # end
  
end
