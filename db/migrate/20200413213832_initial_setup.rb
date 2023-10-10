# frozen_string_literal: true

class InitialSetup < ActiveRecord::Migration[6.0]
  def change
    create_table "accounts", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.string "email", null: false
      t.string "type", null: false
      t.index "lower((email)::text) varchar_pattern_ops", name: "index_accounts_on_email", unique: true
      t.index ["type"], name: "index_accounts_on_type"
      t.index ["user_id"], name: "index_accounts_on_user_id"
    end

    create_table "administrators", force: :cascade do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at", precision: nil
      t.datetime "remember_created_at", precision: nil
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at", precision: nil
      t.datetime "last_sign_in_at", precision: nil
      t.inet "current_sign_in_ip"
      t.inet "last_sign_in_ip"
      t.integer "failed_attempts", default: 0, null: false
      t.string "unlock_token"
      t.datetime "locked_at", precision: nil
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index "lower((email)::text) varchar_pattern_ops", name: "index_administrators_on_email", unique: true
      t.index ["reset_password_token"], name: "index_administrators_on_reset_password_token", unique: true
      t.index ["unlock_token"], name: "index_administrators_on_unlock_token", unique: true
    end

    create_table "calendar_instances", force: :cascade do |t|
      t.bigint "account_id", null: false
      t.bigint "calendar_id", null: false
      t.string "type", null: false
      t.index ["account_id", "calendar_id"], name: "index_calendar_instances_on_account_id_and_calendar_id", unique: true
      t.index ["type"], name: "index_calendar_instances_on_type"
    end

    create_table "calendars", force: :cascade do |t|
      t.string "remote_id", null: false
      t.string "type", null: false
      t.index "lower((remote_id)::text) varchar_pattern_ops", name: "index_calendars_on_remote_id", unique: true
      t.index ["type"], name: "index_calendars_on_type"
    end

    create_table "users", force: :cascade do |t|
      t.string "email", default: "", null: false
      t.index "lower((email)::text) varchar_pattern_ops", name: "index_users_on_email", unique: true
    end
  end
end
