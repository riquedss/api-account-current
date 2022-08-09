# frozen_string_literal: true

class CreateVisits < ActiveRecord::Migration[7.0]
  def change
    create_table(:visits) do |t|
      t.float(:balance)
      t.integer(:status, default: 0)

      t.timestamps
    end
  end
end
