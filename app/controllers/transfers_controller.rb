# frozen_string_literal: true

class TransfersController < ApplicationController
  before_action except: %i[create] do verify_authenticated('manager') end
  before_action only: %i[create] do @checking_account = verify_authenticated_checking_account end
  before_action :set_transfer, only: %i[show update destroy]

  def index
    @transfers = transfer_status
    render(json: @transfers)
  end

  def show
    render(json: @transfer)
  end

  def create
    @transfer_sent = Transfer.new(transfer_params_with_account)
    unless @transfer_sent.save
      return render(json: @transfer_sent.errors,
                    status: :unprocessable_entity)
    end

    @transfer_received = Transfer.new(transfer_params_received)
    unless @transfer_received.save
      return render(json: @transfer_received.errors,
                    status: :unprocessable_entity)
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
    transfer['checking_account_id'] = @checking_account.id
    transfer
  end

  def transfer_params_received
    @checking_account_received = CheckingAccount.find_by(account: @transfer_sent.transfer_account)
    {
      balance: @transfer_sent.balance,
      status: 1,
      transfer_account: @checking_account.account,
      checking_account_id: @checking_account_received.id
    }
  end

  def transfer_status
    case params['status']
    when 'sent'
      Transfer.sent

    when 'received'
      Transfer.received

    else
      Transfer.all
    end
  end
end
