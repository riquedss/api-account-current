# frozen_string_literal: true

module Operations
  class CheckingAccountOperation
    def self.checking_account_positive(account)
      (-1 * account.balance)
    end

    def self.interest_in_minutes(account)
      (Time.zone.now - account.updated_at) / 60
    end

    def self.fees(account)
      checking_account_positive(account) * ((1 + 0.001)**interest_in_minutes(account))
    end

    def self.interest_adjustment(user, account)
      if user.vip? && account.balance.negative?
        fees(account) - checking_account_positive(account)
      else
        0
      end
    end
  end
end
