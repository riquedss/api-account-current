class OperationsController < ApplicationController
  before_action :verify_authenticated_checking_account
  before_action :set_operation, only: %i[ show update destroy ]
  before_action :set_checking_account, :set_user, only: %i[ create ]

  def index
    @operations = operations_status
    render(json: @operations)
  end

  def show
    render(json: @operation)
  end

  def create
    @operation = Operation.new(operation_params_with_account)
    if @operation.save && @checking_account.update(param_update_balance)
      render(json: @operation, status: :created, location: @operation)
    else
      render(json: @operation.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @operation.update(operation_params)
      render(json: @operation)
    else
      render(json: @operation.errors, status: :unprocessable_entity)
    end
  end

  def destroy
    @operation.destroy
  end

  private
    def set_operation
      @operation = Operation.find(params[:id])
    end

    def set_checking_account
      @checking_account = CheckingAccount.find(id_checking_account)
    end
    
    def set_user
      @user = User.find(@checking_account.user_id)
    end
    
    def operation_params
      params.require(:operation).permit(:balance, :status) 
    end  

    def param_update_balance
      juros = Operations::CheckingAccountOperation.interest_adjustment(@user, @checking_account)
      if @operation.withdraw?
        { balance:  @checking_account.balance - @operation.balance - juros }
      else
        { balance:  @checking_account.balance + @operation.balance - juros }
      end 
    end
    
    def operation_params_with_account
      operation = operation_params
      operation["checking_account_id"] = id_checking_account
      return operation
    end

    def id_checking_account
      current_checking_account.id
    end

    def operations_status
      @status = params["status"]
      if (@status == "deposit") 
        return Operation.deposit

      elsif (@status == "withdraw")
        return Operation.withdraw

      else
        return Operation.all
      end
    end
end
