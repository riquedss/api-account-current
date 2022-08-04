Rails.application.routes.draw do
  post 'signup', to: 'auth#signup'
  post 'login', to: 'auth#login'

  post 'checking_account/signup', to: 'auth_accounts#signup'
  post 'checking_account/login', to: 'auth_accounts#login'

  resources :transfers
  resources :users
  resources :checking_accounts
  resources :operations
end
