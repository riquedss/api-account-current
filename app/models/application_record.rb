# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  REGEX_LETRA = /\A[a-zA-Z]+\z/
  REGEX_EMAIL = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  REGEX_CPF = /[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}-?[0-9]{2}/
  REGEX_NUMBER = /[0-9]/

  def positive
    errors.add(:balance, 'balance is not positive') if balance <= 0
  end

  def user(id)
    User.find(id)
  end
end
