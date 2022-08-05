class TransfersController < ApplicationController
  before_action :verify_authenticated_checking_account
  before_action :set_transfer, only: %i[ show update destroy ]

  def index
    @transfers = transfer_status
    render(json: @transfers)
  end

  def show
    render(json: @transfer)
  end

  def create
    @transfer = Transfer.new(transfer_params)

    if @transfer.save
      render(json: @transfer, status: :created)
    else
      render(json: @transfer.errors, status: :unprocessable_entity)
    end
  end

  def update
    if @transfer.update(transfer_params)
      render json: @transfer
    else
      render json: @transfer.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @transfer.destroy
  end

  private
    def set_transfer
      @transfer = Transfer.find(params[:id])
    end

    def transfer_params
      params.require(:transfer).permit(:recipient_account, :balance)
    end

    def transfer_status
      @status = params["status"]
      if (@status == "sent") 
        return Transfer.sent

      elsif (@status == "received")
        return Transfer.received

      else
        return Transfer.all
      end
    end
end
