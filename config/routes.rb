Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  
  root "aux#splash"
  devise_for :users
  resources :groups do
    resources :entities
  end
  #get '/splash', to: "aux#splash"
end
