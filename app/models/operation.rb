class Operation < ApplicationRecord
    belongs_to :checking_account

    validates :balance, :status, presence: true
    
    enum status: { deposit: 0, withdraw: 1 }
end
