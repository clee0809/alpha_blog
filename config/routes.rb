Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'about', to: 'pages#about'
  # this resources have every routes eventually
  # if resources have all routes, don't need to use routes as below
  # and RESTful routes
  resources :articles
  # resources :articles, only: [:show, :index, :new, :create, :edit, :update, :destroy] 
  
end
