Rails.application.routes.draw do
  devise_for :users

  root to: "cars#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :cars do
    resources :bookings, only: [:create, :new, :destroy]

    collection do
      get :my_cars
    end

  end

  resources :bookings, only: :index do
    collection do
      get :my_bookings
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"

end
