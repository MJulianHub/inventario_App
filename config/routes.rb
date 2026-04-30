Rails.application.routes.draw do
  root "categories#index"
  resources :categories
  resources :products
  resources :stocks, only: [ :index, :new, :create ]
  match "*patch", to: redirect("categories"), via: :all

  get "up" => "rails/health#show", as: :rails_health_check
end
