class AddTransferAccountToTransfers < ActiveRecord::Migration[7.0]
  def change
    add_column :transfers, :transfer_account, :string
  end
end
