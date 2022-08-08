# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table(:users) do |t|
      t.string(:name)
      t.string(:last_name)
      t.integer(:role, default: 0)
      t.string(:email)
      t.string(:cpf)
      t.string(:password_digest)

      t.timestamps
    end

    add_index(:users, :email, unique: true)
    add_index(:users, :cpf, unique: true)
  end
end
