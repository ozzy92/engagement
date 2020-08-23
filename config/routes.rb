Rails.application.routes.draw do
  resources :employees
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :departments
  resources :cost_centers
  resources :mail_codes
  resources :engagement_requests
  root 'home#index'
end
