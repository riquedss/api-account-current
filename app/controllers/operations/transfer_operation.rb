# frozen_string_literal: true

module Operations
  class TransferOperation
    def self.update_transfer_balance(transfer)
      if transfer.sent?
        update_sender_balance(transfer)
      else
        update_recipient_balance(transfer)
      end
    end

    def self.update_sender_balance(transfer)
      @checking_account = CheckingAccount.find(transfer.checking_account_id)
      @user = User.find_by(id: @checking_account.user_id)
      update_balance(calculate_balance_sender(@checking_account, transfer))
    end

    def self.calculate_balance_sender(checking_account, transfer)
      if @user.vip?
        { balance: checking_account.balance - transfer.balance - (transfer.balance * 0.008) }
      else
        { balance: checking_account.balance - transfer.balance - 8 }
      end
    end

    def self.update_recipient_balance(transfer)
      @checking_account = CheckingAccount.find(transfer.checking_account_id)
      update_balance({ balance: @checking_account.balance + transfer.balance })
    end

    def self.update_balance(params)
      @checking_account.update(params)
    end
  end
end
