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

ActiveRecord::Schema.define(version: 20161228220934) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "account_type"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "score_cents",    default: 0,     null: false
    t.string   "score_currency", default: "USD", null: false
    t.boolean  "active",         default: false
    t.index ["user_id"], name: "index_accounts_on_user_id", using: :btree
  end

  create_table "ardis_transactions", force: :cascade do |t|
    t.integer  "borrower_id"
    t.integer  "investor_id"
    t.integer  "kind"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
  end

  create_table "ardis_transactions_debts", force: :cascade do |t|
    t.integer  "debt_id"
    t.integer  "ardis_transaction_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["ardis_transaction_id"], name: "index_ardis_transactions_debts_on_ardis_transaction_id", using: :btree
    t.index ["debt_id"], name: "index_ardis_transactions_debts_on_debt_id", using: :btree
  end

  create_table "borrower_requests", force: :cascade do |t|
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "account_id"
    t.integer  "status"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.integer  "duration"
    t.index ["account_id"], name: "index_borrower_requests_on_account_id", using: :btree
  end

  create_table "credit_histories", force: :cascade do |t|
    t.integer  "number"
    t.float    "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_scores", force: :cascade do |t|
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
    t.decimal  "score"
    t.index ["account_id"], name: "index_credit_scores_on_account_id", using: :btree
  end

  create_table "debts", force: :cascade do |t|
    t.integer  "status"
    t.integer  "borrower_request_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "investor_request_id"
    t.index ["borrower_request_id"], name: "index_debts_on_borrower_request_id", using: :btree
  end

  create_table "debts_status_histories", force: :cascade do |t|
    t.integer  "status"
    t.integer  "debt_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["debt_id"], name: "index_debts_status_histories_on_debt_id", using: :btree
  end

  create_table "documents", force: :cascade do |t|
    t.integer  "account_id"
    t.text     "note",       default: "", null: false
    t.string   "file",                    null: false
    t.integer  "status",     default: 0,  null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["account_id"], name: "index_documents_on_account_id", using: :btree
  end

  create_table "frequently_asked_questions", force: :cascade do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investor_requests", force: :cascade do |t|
    t.decimal  "from_rate"
    t.decimal  "to_rate"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "account_id"
    t.integer  "status"
    t.integer  "amount_cents",    default: 0,     null: false
    t.string   "amount_currency", default: "USD", null: false
    t.datetime "due_date"
    t.index ["account_id"], name: "index_investor_requests_on_account_id", using: :btree
  end

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "sex"
    t.string   "home_phone"
    t.string   "mobile_phone"
    t.string   "company_name"
    t.string   "job_position"
    t.string   "nationality"
    t.string   "credit_number"
    t.string   "address"
    t.decimal  "salary"
    t.integer  "family_status"
    t.date     "birth_date"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "support_replies", force: :cascade do |t|
    t.integer  "support_request_id"
    t.integer  "user_id"
    t.text     "content"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["support_request_id"], name: "index_support_replies_on_support_request_id", using: :btree
    t.index ["user_id"], name: "index_support_replies_on_user_id", using: :btree
  end

  create_table "support_requests", force: :cascade do |t|
    t.text     "content"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_support_requests_on_user_id", using: :btree
  end

  create_table "system_scores", force: :cascade do |t|
    t.integer  "score_cents",    default: 0,     null: false
    t.string   "score_currency", default: "USD", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "allowed_to_log_in",      default: true
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.string   "invited_by_type"
    t.integer  "invited_by_id"
    t.integer  "invitations_count",      default: 0
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
    t.index ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "ardis_transactions_debts", "ardis_transactions"
  add_foreign_key "ardis_transactions_debts", "debts"
  add_foreign_key "debts", "borrower_requests"
  add_foreign_key "debts", "investor_requests"
  add_foreign_key "debts_status_histories", "debts"
  add_foreign_key "documents", "accounts"
  add_foreign_key "profiles", "users"
end
