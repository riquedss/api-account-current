# frozen_string_literal: true

class AddUserRefToCheckingAccounts < ActiveRecord::Migration[7.0]
  def change
    add_reference(:checking_accounts, :user, null: false, foreign_key: true)
  end
end
