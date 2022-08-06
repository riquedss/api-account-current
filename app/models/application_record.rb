class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  REGEX_LETRA = /\A[a-zA-Z]+\z/
  REGEX_EMAIL = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  REGEX_CPF = /[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{2}/
  REGEX_NUMBER = /[0-9]/

  def positive
    if (self.balance <= 0)
      errors.add(:balance, "balance is not positive")
    end
  end

  def user(checking_account)
    User.find(checking_account.user_id)
  end
end
