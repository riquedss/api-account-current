class CreateTransfers < ActiveRecord::Migration[7.0]
  def change
    create_table :transfers do |t|
      t.string :recipient_account
      t.float :balance
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
