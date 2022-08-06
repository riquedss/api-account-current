module Operations
  class CheckingAccountOperation
    def self.checking_account_positive(checking_account)
        return ((-1) * checking_account.balance )
    end
    
    def self.interest_time_in_minutes(checking_account)
      return (Time.new - checking_account.updated_at)/60
    end

    def self.fees(checking_account)
      return checking_account_positive(checking_account) * (1 + 0.001) ** interest_time_in_minutes(checking_account)
    end

    def self.interest_adjustment(user, checking_account)
        if (user.vip?) &&  (checking_account.balance < 0)
          return fees(checking_account) - checking_account_positive(checking_account)
        else
          return 0
        end   
    end
  end
end