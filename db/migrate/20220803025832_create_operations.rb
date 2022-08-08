# frozen_string_literal: true

class CreateOperations < ActiveRecord::Migration[7.0]
  def change
    create_table(:operations) do |t|
      t.float(:balance)
      t.integer(:status)

      t.timestamps
    end
  end
end
