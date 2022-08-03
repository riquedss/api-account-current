Rails.application.routes.draw do
  resources :transfers
  resources :users
  resources :checking_accounts
  resources :operations
end
