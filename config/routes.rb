Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  
  root "aux#splash"
  devise_for :users, only: [:sessions, :registrations]
  resources :groups, only: [:index, :new, :create] do
    resources :entities, only: [:index, :new, :create]
  end
end
