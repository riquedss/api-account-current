class AuthAccountsController < ApplicationController
  before_action :verify_authenticated_user

  def signup
    @checking_account = CheckingAccount.new(checking_account_params)

    if @checking_account.save
      render(json: @checking_account, status: :created)
    else
      render(json: @checking_account.errors, status: :unprocessable_entity)
    end
  end

  def login
    @checking_account = CheckingAccount.find_by(account: login_params[:account])
    if @checking_account&&@checking_account.authenticate(login_params[:password])
      token_account = JsonWebToken::Base.encode(checking_account_id: @checking_account.id)
      render(json: { checking_account: @checking_account, token_account: token_account },  status: :ok)
    else
      render(json: { message: "Account or Password incorrect" }, status: :unauthorized)
    end
  end

  private

  def checking_account_params
    @checking_account = params.require(:checking_account).permit(:password, :password_confirmation)
    @checking_account[:user_id] = current_user.id

    return @checking_account
  end
  
  def login_params
    params.require(:checking_account).permit(:account, :password)
  end
end
