# frozen_string_literal: true

class CheckingAccount < ApplicationRecord
  belongs_to :user
  has_many :operations, dependent: :nullify
  has_many :transfers, dependent: :nullify

  has_secure_password

  validate  :account_generator, on: [:create]
  validates :balance, :account, presence: true
  validates :account, uniqueness: true, length: { is: 5 }
  validates :password, format: { with: REGEX_NUMBER }, length: { is: 4 }, on: [:create]

  enum status: { on_hold: 0, active: 1, inactive: 2 }

  def account_generator
    @account = rand(10_000...99_999).to_s
    @account = rand(10_000...99_999).to_s while account_check
    self.account = @account
  end

  def account_check
    CheckingAccount.find_by(account: @account)
  end
end
