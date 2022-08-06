class Operation < ApplicationRecord
    belongs_to :checking_account

    validates :balance, :status, presence: true
    validate :positive
    validate :withdrawal_is_valid, if: :status_withdrawa_role_user_comum
    
    enum status: { deposit: 0, withdraw: 1 }

    def status_withdrawa_role_user_comum
      @checking_account = CheckingAccount.find(self.checking_account_id)
      return self.withdraw? && user(@checking_account.user_id).comum? 
    end

    def withdrawal_is_valid
      if !(self.balance <= @checking_account.balance)
        errors.add(:balance, "insufficient balance for this withdrawal")
      end       
    end
end
