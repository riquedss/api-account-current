class UsersController < ApplicationController
  before_action :verify_authenticated_user
  before_action :set_user, only: %i[ show update destroy ]

  def index
    @users = User.all
    render(json: @users)
  end

  def show
    render(json: @user)
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render(json: @user, status: :created)
    else
      render(json: @user.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @user.update(user_params)
      render(json: @user)
    else
      render(json: @user.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :last_name, :email, :cpf, :password, :password_confirmation)
    end
end
