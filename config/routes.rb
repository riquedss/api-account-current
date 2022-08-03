Rails.application.routes.draw do
  resources :users
  resources :checking_accounts
  resources :operations
end
