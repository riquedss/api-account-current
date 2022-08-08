# frozen_string_literal: true

class CheckingAccountsController < ApplicationController
  before_action except: %i[show_accounts_user show_account show_extrato] do
    verify_authenticated('manager')
  end
  before_action only: %i[show_accounts_user] do @user = verify_authenticated('user') end
  before_action only: %i[show_account show_extrato] do
    @account = verify_authenticated_checking_account
  end
  before_action :set_checking_account, only: %i[show update destroy]
  before_action :set_account_for, only: %i[active_checking_account]

  def index
    @checking_accounts = checking_account_status
    render(json: @checking_accounts)
  end

  def show
    render(json: @checking_account)
  end

  def show_accounts_user
    @checking_accounts = CheckingAccount.where(user_id: @user.id).active
    render(json: @checking_accounts)
  end

  def show_account
    @checking_account = CheckingAccount.find(@account.id)
    render(json: @checking_account)
  end

  def show_extrato
    @extrato = Operations::ExtratoOperation.extrato(@account)
    render(json: @extrato)
  end

  def create
    @checking_account = CheckingAccount.new(checking_account_params)

    if @checking_account.save
      render(json: @checking_account, status: :created)
    else
      render(json: @checking_account.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @checking_account.update(checking_account_params)
      render(json: @checking_account)
    else
      render(json: @checking_account.errors, status: :unprocessable_entity)
    end
  end

  def active_checking_account
    if @checking_account.update({ status: 1 })
      render(json: @checking_account)
    else
      render(json: @checking_account.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @checking_account.destroy
  end

  private

  def set_checking_account
    @checking_account = CheckingAccount.find(params[:id])
  end

  def set_account_for
    @checking_account = CheckingAccount.find_by(account: params[:checking_account][:account])
    render(json: { message: 'Not_found' }, status: :not_found) unless @checking_account
  end

  def checking_account_params
    params.require(:checking_account).permit(:password, :password_confirmation)
  end

  def checking_account_status
    case params['status']
    when 'on_hold'
      CheckingAccount.on_hold

    when 'active'
      CheckingAccount.active

    when 'inactive'
      CheckingAccount.inactive

    else
      CheckingAccount.all
    end
  end
end
