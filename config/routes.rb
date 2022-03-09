Rails.application.routes.draw do
  devise_for :users

  resources :borrow_books
  resources :books

  get 'home', to: 'pages#home'
  get 'about', to: 'pages#about'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home"
  post '/borrow_book' => 'borrow_books#create'
end