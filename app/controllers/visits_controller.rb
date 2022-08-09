# frozen_string_literal: true

class VisitsController < ApplicationController
  before_action except: %i[create] do verify_authenticated('manager') end
  before_action only: %i[create] do @checking_account = verify_authenticated_checking_account end
  before_action :set_visit, only: %i[show update destroy]

  def index
    @visits = Visit.all

    render(json: @visits)
  end

  def show
    render(json: @visit)
  end

  def create
    @visit = Visit.new({ checking_account_id: @checking_account.id })

    if validar_user && @visit.save && @checking_account.update(params_visit)
      render(json: @visit, status: :created)
    else
      render(json: @visit.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @visit.update(visit_params)
      render(json: @visit)
    else
      render(json: @visit.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @visit.destroy
  end

  private

  def set_visit
    @visit = Visit.find(params[:id])
  end

  def params_visit
    { balance: @checking_account.balance - 50 }
  end

  def validar_user
    user = User.find(@checking_account.user_id)
    return true if user.vip?
  end
end
