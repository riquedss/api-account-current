class Transfer < ApplicationRecord
    belongs_to :checking_account

    validates :recipient_account, :balance, presence: true
    validates :recipient_account, format: { with: REGEX_NUMBER }, length: { is: 5}
    validate :positive, :recipient_account_exist, :recipient_account_different_sender
    validate :limite, if: :user_comum

    enum status: { sent: 0, received: 1 }

    def recipient_account_exist
      @checking_account = CheckingAccount.find_by(account: self.recipient_account )
      if !@checking_account
        errors.add(:recipient_account, "account does not exist")
      end
    end

    def recipient_account_different_sender
    @checking_account = CheckingAccount.find(self.checking_account_id)
      if @checking_account.account == self.recipient_account
        errors.add(:recipient_account, "invalid transfer")
      end
    end

    def limite
      if (self.balance > 1000) && ((self.balance + 8) > @checking_account.balance)
        errors.add(:balance, "only vip can transfer more than 1000 and get a negative balance")
      end
    end

    def user_comum
        user(@checking_account).comum?
    end
end
