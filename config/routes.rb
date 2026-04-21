Rails.application.routes.draw do
  resources :categories
  resources :products
  resources :stocks, only: [ :index, :new, :create ]

  get "up" => "rails/health#show", as: :rails_health_check
end
