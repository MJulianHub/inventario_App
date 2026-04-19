Rails.application.routes.draw do
  root "categories#index"
  resources :categories
  get "up" => "rails/health#show", as: :rails_health_check
end
