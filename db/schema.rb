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

ActiveRecord::Schema.define(version: 2020_05_22_175122) do

  create_table "achievement_categories", force: :cascade do |t|
    t.integer "achievement_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id", "tag_id"], name: "index_achievement_categories_on_achievement_id_and_tag_id", unique: true
    t.index ["achievement_id"], name: "index_achievement_categories_on_achievement_id"
    t.index ["tag_id"], name: "index_achievement_categories_on_tag_id"
  end

  create_table "achievements", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "introduction", null: false
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_achievements_on_user_id"
  end

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

  create_table "blocks", force: :cascade do |t|
    t.integer "blocker_id", null: false
    t.integer "blocked_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_id"], name: "index_blocks_on_blocked_id"
    t.index ["blocker_id", "blocked_id"], name: "index_blocks_on_blocker_id_and_blocked_id", unique: true
    t.index ["blocker_id"], name: "index_blocks_on_blocker_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.integer "proposition_id", null: false
    t.integer "room_id", null: false
    t.text "content"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposition_id"], name: "index_chat_messages_on_proposition_id"
    t.index ["room_id"], name: "index_chat_messages_on_room_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "proposition_id", null: false
    t.text "content"
    t.string "image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposition_id"], name: "index_comments_on_proposition_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "proposition_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposition_id"], name: "index_favorites_on_proposition_id"
    t.index ["user_id", "proposition_id"], name: "index_favorites_on_user_id_and_proposition_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.integer "follower_id", null: false
    t.integer "followed_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_follows_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_follows_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "offers", force: :cascade do |t|
    t.integer "offering_id", null: false
    t.integer "offered_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["offered_id"], name: "index_offers_on_offered_id"
    t.index ["offering_id"], name: "index_offers_on_offering_id"
  end

  create_table "prefectures", force: :cascade do |t|
    t.integer "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "proposition_categories", force: :cascade do |t|
    t.integer "proposition_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposition_id", "tag_id"], name: "index_proposition_categories_on_proposition_id_and_tag_id", unique: true
    t.index ["proposition_id"], name: "index_proposition_categories_on_proposition_id"
    t.index ["tag_id"], name: "index_proposition_categories_on_tag_id"
  end

  create_table "proposition_rooms", force: :cascade do |t|
    t.integer "proposition_id", null: false
    t.integer "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposition_id", "room_id"], name: "index_proposition_rooms_on_proposition_id_and_room_id", unique: true
    t.index ["proposition_id"], name: "index_proposition_rooms_on_proposition_id"
    t.index ["room_id"], name: "index_proposition_rooms_on_room_id"
  end

  create_table "propositions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title", null: false
    t.text "introduction", null: false
    t.date "deadline"
    t.integer "barter_status", default: 1
    t.string "rendering_image_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["barter_status"], name: "index_propositions_on_barter_status"
    t.index ["deadline"], name: "index_propositions_on_deadline"
    t.index ["introduction"], name: "index_propositions_on_introduction"
    t.index ["title"], name: "index_propositions_on_title"
    t.index ["user_id"], name: "index_propositions_on_user_id"
  end

  create_table "request_categories", force: :cascade do |t|
    t.integer "proposition_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposition_id", "tag_id"], name: "index_request_categories_on_proposition_id_and_tag_id", unique: true
    t.index ["proposition_id"], name: "index_request_categories_on_proposition_id"
    t.index ["tag_id"], name: "index_request_categories_on_tag_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "proposition_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["proposition_id"], name: "index_reviews_on_proposition_id"
    t.index ["user_id", "proposition_id"], name: "index_reviews_on_user_id_and_proposition_id", unique: true
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skill_categories", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_skill_categories_on_tag_id"
    t.index ["user_id", "tag_id"], name: "index_skill_categories_on_user_id_and_tag_id", unique: true
    t.index ["user_id"], name: "index_skill_categories_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
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
    t.integer "user_status", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone_number"], name: "index_users_on_phone_number", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
