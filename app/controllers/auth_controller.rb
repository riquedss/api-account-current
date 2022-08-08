# frozen_string_literal: true

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
    @user = User.find_by(cpf: login_params[:cpf])
    if @user&.authenticate(login_params[:password])
      token = JsonWebToken::Base.encode(user_id: @user.id)
      render(json: { user: @user, token: token },  status: :ok)
    else
      render(json: { message: 'Cpf or Password incorrect' }, status: :unauthorized)
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :last_name, :email, :cpf, :password, :password_confirmation)
  end

  def login_params
    params.require(:user).permit(:cpf, :password)
  end
end
