Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  root "books#show"
  get '/books/index', to: 'books#index' ,as: 'show_books'
  get '/books/new', to: 'books#new' , as: 'new_books'
  post '/books', to: 'books#create'
  get '/books/edit/:id', to: 'books#edit', as: 'books_edit'
  put '/books/:id', to: 'books#update'

  get '/rails/books/index', to: 'books#index' ,as: 'rails_books_index'
  get '/rails/books/new', to: 'books#new' , as: 'rails_new_books'
  post '/rails/books', to: 'books#create' , as: 'rails_books_create'
  get '/rails/books/:id/edit', to: 'books#edit' ,as: 'rails_books_edit'
  put '/rails/books/:id', to: 'books#update' ,as: 'rails_books_update'
  delete '/rails/books/:id', to: 'books#destroy' ,as: 'rails_books_destroy'
  
  get '/profile', to: "books#profile"

  scope :rails do
    resources :books
  end
end
