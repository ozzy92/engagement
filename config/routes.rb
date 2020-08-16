Rails.application.routes.draw do
  get 'home/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :departments
  resources :cost_centers
  resources :engagement_requests
  root 'home#index'
end
