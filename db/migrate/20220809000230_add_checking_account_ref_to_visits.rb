class AddCheckingAccountRefToVisits < ActiveRecord::Migration[7.0]
  def change
    add_reference :visits, :checking_account, null: false, foreign_key: true
  end
end
