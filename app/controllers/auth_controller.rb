class AuthController < ApplicationController
  def signup
    @user = User.new(user_params)

    if @user.save
      render(json: @user, status: :created)
    else
      render(json: @user.errors, status: :unprocessable_entity)
    end
  end

  def login
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :cpf, :password, :password_confirmation)
  end
end
