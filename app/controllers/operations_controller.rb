class OperationsController < ApplicationController
  before_action :verify_authenticated_checking_account
  before_action :set_operation, only: %i[ show update destroy ]

  def index
    @operations = operations_status
    render(json: @operations)
  end

  def show
    render(json: @operation)
  end

  def create
    @operation = Operation.new(operation_params)

    if @operation.save
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

    def operation_params
      params.require(:operation).permit(:balance, :status)
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
