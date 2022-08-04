class CheckingAccount < ApplicationRecord
    belongs_to :user
    has_many :operations
    has_many :transfers

    has_secure_password
    
    validate  :account_generator
    validates :balance, :account, presence: true
    validates :account, uniqueness: true, length: { is: 5 }
    validates :password, format: { with: REGEX_NUMBER }, length: { is: 4}

    enum status: { on_hold: 0, active: 1, inactive: 2 }

    def account_generator
        @account = "#{rand(10000...99999)}"
        while(account_check) do
            @account = "#{rand(10000...99999)}"
        end
        self.account = @account
    end 

    def account_check
        return CheckingAccount.find_by(account: @account)
    end
end
