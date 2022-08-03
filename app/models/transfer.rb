class Transfer < ApplicationRecord
    validates :recipient_account, :balance, presence: true
    validates :recipient_account, format: { with: REGEX_NUMBER }, length: { is: 5}

    enum status: { sent: 0, received: 1 }
end