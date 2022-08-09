# frozen_string_literal: true

Rails.application.routes.draw do
  post 'signup', to: 'auth#signup'
  post 'login', to: 'auth#login'

  post 'checking_account/signup', to: 'auth_accounts#signup'
  post 'checking_account/login', to: 'auth_accounts#login'
  put 'checking_account/active', to: 'checking_accounts#active_checking_account'
  get 'checking_account/active/user', to: 'checking_accounts#show_accounts_user'
  get 'checking_account/user', to: 'checking_accounts#show_account'
  get 'checking_account/extrato', to: 'checking_accounts#show_extrato'

  resources :visits
  resources :transfers
  resources :users
  resources :checking_accounts
  resources :operations
end
