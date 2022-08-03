class Operation < ApplicationRecord
    validates :balance, :status, presence: true
    
    enum status: { deposit: 0, withdraw: 1 }
end
