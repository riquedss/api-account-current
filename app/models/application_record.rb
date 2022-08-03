class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  REGEX_LETRA = /\A[a-zA-Z]+\z/
  REGEX_EMAIL = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
  REGEX_CPF = /[0-9]{3}\.?[0-9]{3}\.?[0-9]{3}\-?[0-9]{2}/
  REGEX_NUMBER = /[0-9]/
end
