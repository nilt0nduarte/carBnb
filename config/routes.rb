Rails.application.routes.draw do
  devise_for :users

  root to: "cars#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :cars do
    collection do
      get :my_cars
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"

end
