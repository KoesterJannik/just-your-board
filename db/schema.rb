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

ActiveRecord::Schema[8.0].define(version: 2025_04_21_195928) do
  create_table "board_users", force: :cascade do |t|
    t.integer "board_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_board_users_on_board_id"
    t.index ["user_id"], name: "index_board_users_on_user_id"
  end

  create_table "boards", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_boards_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "column_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "priority"
    t.integer "position"
    t.integer "assignee_id"
    t.index ["assignee_id"], name: "index_cards_on_assignee_id"
    t.index ["column_id"], name: "index_cards_on_column_id"
  end

  create_table "columns", force: :cascade do |t|
    t.string "name"
    t.integer "board_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["board_id"], name: "index_columns_on_board_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "board_users", "boards"
  add_foreign_key "board_users", "users"
  add_foreign_key "boards", "users"
  add_foreign_key "cards", "columns"
  add_foreign_key "cards", "users", column: "assignee_id"
  add_foreign_key "columns", "boards"
  add_foreign_key "sessions", "users"
end
