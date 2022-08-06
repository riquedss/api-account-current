class RemoveRecipientAccountFromTransfers < ActiveRecord::Migration[7.0]
  def change
    remove_column :transfers, :recipient_account, :string
  end
end
