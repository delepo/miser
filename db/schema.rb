# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150122153045) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "bank_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "code"
    t.decimal  "balance",    default: 0.0
  end

  add_index "accounts", ["bank_id"], name: "index_accounts_on_bank_id"

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "bank_code"
    t.string   "branch_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "operations", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "transfer_operation_id"
    t.decimal  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
  end

  add_index "operations", ["account_id"], name: "index_operations_on_account_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
