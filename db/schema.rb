# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_08_09_000230) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checking_accounts", force: :cascade do |t|
    t.float "balance", default: 0.0
    t.string "account"
    t.integer "status", default: 0
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["account"], name: "index_checking_accounts_on_account", unique: true
    t.index ["user_id"], name: "index_checking_accounts_on_user_id"
  end

  create_table "operations", force: :cascade do |t|
    t.float "balance"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "checking_account_id", null: false
    t.index ["checking_account_id"], name: "index_operations_on_checking_account_id"
  end

  create_table "transfers", force: :cascade do |t|
    t.float "balance"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "checking_account_id", null: false
    t.string "transfer_account"
    t.index ["checking_account_id"], name: "index_transfers_on_checking_account_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "last_name"
    t.integer "role", default: 0
    t.string "email"
    t.string "cpf"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cpf"], name: "index_users_on_cpf", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "visits", force: :cascade do |t|
    t.float "balance"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "checking_account_id", null: false
    t.index ["checking_account_id"], name: "index_visits_on_checking_account_id"
  end

  add_foreign_key "checking_accounts", "users"
  add_foreign_key "operations", "checking_accounts"
  add_foreign_key "transfers", "checking_accounts"
  add_foreign_key "visits", "checking_accounts"
end
