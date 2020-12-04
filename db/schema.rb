# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2020_12_03_040959) do
=======
ActiveRecord::Schema.define(version: 2020_11_29_221442) do
>>>>>>> admin

  # These are extensions that must be enabAccounAccount.where(id: current_user.id).namet.where(id: current_user.id).nameled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "balance_cents", default: 0, null: false
    t.string "balance_currency", default: "CLP", null: false
    t.string "account_type"
    t.bigint "quota"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
  end

  create_table "debts", force: :cascade do |t|
    t.integer "interest"
    t.integer "amount"
    t.string "acreedor_type", null: false
    t.bigint "acreedor_id", null: false
    t.string "deudor_type", null: false
    t.bigint "deudor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "currency", default: "CLP", null: false
    t.index ["acreedor_type", "acreedor_id"], name: "index_debts_on_acreedor_type_and_acreedor_id"
    t.index ["deudor_type", "deudor_id"], name: "index_debts_on_deudor_type_and_deudor_id"
  end

  create_table "movements", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "account_id", null: false
    t.integer "final_balance"
    t.integer "amount"
    t.text "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_movements_on_account_id"
    t.index ["category_id"], name: "index_movements_on_category_id"
  end

  create_table "natural_people", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "related_account"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "origin_movement_id"
    t.integer "target_movement_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_transactions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "role"
    t.boolean "admin", default: false
    t.boolean "enabled", default: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "movements", "accounts"
  add_foreign_key "movements", "categories"
  add_foreign_key "transactions", "users"
end
