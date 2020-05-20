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

ActiveRecord::Schema.define(version: 2020_05_20_165957) do

  create_table "background_jobs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "company_name", null: false
    t.string "department"
    t.string "position"
    t.date "joining_date", null: false
    t.date "retirement_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_name"], name: "index_background_jobs_on_company_name"
    t.index ["department"], name: "index_background_jobs_on_department"
    t.index ["position"], name: "index_background_jobs_on_position"
    t.index ["user_id"], name: "index_background_jobs_on_user_id"
  end

  create_table "background_schools", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "school_name", null: false
    t.integer "school_type", null: false
    t.string "department"
    t.integer "enrollment_status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_name"], name: "index_background_schools_on_school_name"
    t.index ["user_id"], name: "index_background_schools_on_user_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.integer "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_prefectures", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "prefecture_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prefecture_id"], name: "index_user_prefectures_on_prefecture_id"
    t.index ["user_id", "prefecture_id"], name: "index_user_prefectures_on_user_id_and_prefecture_id", unique: true
    t.index ["user_id"], name: "index_user_prefectures_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "kana_name", null: false
    t.date "birthday"
    t.string "phone_number", null: false
    t.text "introduction"
    t.string "profile_image_id"
    t.integer "user_status", default: 1, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
