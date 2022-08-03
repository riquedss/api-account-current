Rails.application.routes.draw do
  post 'signup', to: 'auth#signup'
  post 'login', to: 'auth#login'
  resources :transfers
  resources :users
  resources :checking_accounts
  resources :operations
end
