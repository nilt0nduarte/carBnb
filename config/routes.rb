Rails.application.routes.draw do
  devise_for :users

  root to: "cars#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :cars do
    resources :bookings, only: %i[create new]

    collection do
      get :my_cars
    end
  end

  resources :bookings, only: :destroy

  resources :bookings, only: %i[index edit update] do
    collection do
      get :my_bookings
      get :my_reservations
    end
  end
end
