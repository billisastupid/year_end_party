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

ActiveRecord::Schema.define(version: 2021_03_25_111402) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "prize_records", force: :cascade do |t|
    t.bigint "prize_id"
    t.bigint "user_id"
    t.string "remark"
    t.boolean "active", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["prize_id"], name: "index_prize_records_on_prize_id"
    t.index ["user_id"], name: "index_prize_records_on_user_id"
  end

  create_table "prizes", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.integer "quantity"
    t.integer "fulfilled_quantity", default: 0
    t.boolean "drawable", default: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "bulk", default: 1
    t.string "key"
    t.boolean "limited", default: true
    t.index ["key"], name: "index_prizes_on_key", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "department"
    t.boolean "active", default: false
    t.string "user_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "win", default: false
    t.boolean "drawable", default: false
    t.index ["user_number"], name: "index_users_on_user_number", unique: true
  end

end
