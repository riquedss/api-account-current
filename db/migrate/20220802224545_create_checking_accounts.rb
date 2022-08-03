class CreateCheckingAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :checking_accounts do |t|
      t.float :balance, default: 0
      t.string :account
      t.integer :status, default: 0
      t.string :password_digest

      t.timestamps
    end
  end
end
