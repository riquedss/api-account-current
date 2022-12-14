# frozen_string_literal: true

class Transfer < ApplicationRecord
  belongs_to :checking_account

  validates :transfer_account, :balance, presence: true
  validates :transfer_account, format: { with: REGEX_NUMBER }, length: { is: 5 }
  validate :positive, :transfer_account_exist, :transfer_account_different_sender, if: :sent
  validate :limite, if: :user_comum_and_sent

  enum status: { sent: 0, received: 1 }

  def transfer_account_exist
    @checking_account_received = CheckingAccount.find_by(account: transfer_account)
    errors.add(:transfer_account, 'account does not exist') unless @checking_account_received
  end

  def transfer_account_different_sender
    @checking_account = CheckingAccount.find(checking_account_id)
    return unless @checking_account.account == transfer_account

    errors.add(:transfer_account, 'invalid transfer')
  end

  def limite
    return unless (balance > 1000) || ((balance + 8) > @checking_account.balance)

    errors.add(:balance, 'only vip can have a negative balance or withdraw more than 1000')
  end

  def user_comum_and_sent
    sent? && user(@checking_account.user_id).comum?
  end

  def sent
    sent?
  end
end
