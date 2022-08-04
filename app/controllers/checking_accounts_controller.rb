class CheckingAccountsController < ApplicationController
  before_action :verify_authenticated_user
  before_action :set_checking_account, only: %i[ show update destroy ]

  def index
    @checking_accounts = checking_account_status
    render(json: @checking_accounts)
  end

  def show
    render(json: @checking_account)
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

  def destroy
    @checking_account.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checking_account
      @checking_account = CheckingAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
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
