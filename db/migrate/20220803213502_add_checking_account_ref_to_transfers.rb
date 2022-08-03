class AddCheckingAccountRefToTransfers < ActiveRecord::Migration[7.0]
  def change
    add_reference :transfers, :checking_account, null: false, foreign_key: true
  end
end
