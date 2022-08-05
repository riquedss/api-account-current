class CheckingAccountsController < ApplicationController
  before_action :verify_authenticated_user
  before_action :verify_authenticated_adm, except: %i[ show_account_user ]
  before_action :set_checking_account, only: %i[ show update destroy ]
  before_action :set_account_for, only: %i[ active_checking_account ]

  def index
    @checking_accounts = checking_account_status
    render(json: @checking_accounts)
  end

  def show
    render(json: @checking_account)
  end

  def show_account_user
    @checking_accounts = CheckingAccount.where(user_id: params[:id]).active
    render(json: @checking_accounts)
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
    if @checking_account.update(checking_account_update_params)
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
      if !@checking_account
        render(json: { message: "Not_found" }, status: :not_found)
      end
    end

    def checking_account_update_params
      params.require(:checking_account).permit(:account, :status)
    end

    def checking_account_params
      params.require(:checking_account).permit(:password, :password_confirmation)
    end

    def checking_account_status
      @status = params["status"]
      if (@status == "on_hold") 
        return CheckingAccount.on_hold

      elsif (@status == "active")
        return CheckingAccount.active

      elsif (@status == "inactive")
        return CheckingAccount.inactive
      else
        return CheckingAccount.all
      end
    end
end
