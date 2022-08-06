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
    @transfer_sent = Transfer.new(transfer_params_with_account)
    if !@transfer_sent.save 
      return render(json: @transfer_sent.errors, status: :unprocessable_entity)
    end
    
    @transfer_received = Transfer.new(transfer_params_received)
    if !@transfer_received.save
      return render(json: @transfer_received.errors, status: :unprocessable_entity)
    end
      
    Operations::TransferOperation.update_transfer_balance(@transfer_sent)
    Operations::TransferOperation.update_transfer_balance(@transfer_received)
    render(json: @transfer_sent, status: :created)
  end

  def update
    if @transfer.update(transfer_params)
      render(json: @transfer)
    else
      render(json: @transfer.errors, status: :unprocessable_entity)
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
      params.require(:transfer).permit(:transfer_account, :balance)
    end

    def transfer_params_with_account
      transfer = transfer_params
      transfer["checking_account_id"] = id_checking_account
      return transfer
    end

    def transfer_params_received
      @checking_account_received = CheckingAccount.find_by(account: @transfer_sent.transfer_account)
      @checking_account_sent = CheckingAccount.find(@transfer_sent.checking_account_id)
      return {
        "balance": @transfer_sent.balance,
        "status": 1,
        "transfer_account": @checking_account_sent.account,
        "checking_account_id": @checking_account_received.id
      }
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
