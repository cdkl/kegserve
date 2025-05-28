Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  get "taps" => "taps#index", as: :taps
  get "taps/new" => "taps#new", as: :new_tap
  get "taps/:id" => "taps#show", as: :tap
  post "taps" => "taps#create"
  get "taps/:id/edit" => "taps#edit", as: :edit_tap
  patch "taps/:id" => "taps#update"
  put "taps/:id" => "taps#update"
  delete "taps/:id" => "taps#destroy", as: :destroy_tap
  get "taps/:id/beverage" => "taps#beverage", as: :tap_beverage

  get "beverages" => "beverages#index", as: :beverages
  get "beverages/new" => "beverages#new", as: :new_beverage
  get "beverages/:id" => "beverages#show", as: :beverage
  post "beverages" => "beverages#create"
  get "beverages/:id/edit" => "beverages#edit", as: :edit_beverage
  patch "beverages/:id" => "beverages#update"
  put "beverages/:id" => "beverages#update"
  delete "beverages/:id" => "beverages#destroy", as: :destroy_beverage
end
