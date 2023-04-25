Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  
  root "groups#index"
  devise_for :users
  get '/splash', to: "aux#show"
end
