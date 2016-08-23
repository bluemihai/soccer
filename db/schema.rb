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

ActiveRecord::Schema.define(version: 20160823191603) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "cards", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "player_id"
    t.boolean  "red"
    t.boolean  "yellow"
    t.integer  "minute"
    t.text     "details"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "divisions", force: :cascade do |t|
    t.string   "letter"
    t.integer  "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "formations", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.hstore   "positions"
    t.text     "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "games", force: :cascade do |t|
    t.integer  "home_id"
    t.integer  "away_id"
    t.datetime "kickoff"
    t.text     "referees_report"
    t.integer  "context"
    t.integer  "referee_id"
    t.integer  "field_id"
    t.integer  "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "division_id"
    t.integer  "week"
  end

  create_table "goals", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "team_id"
    t.integer  "scorer_id"
    t.integer  "assister_id"
    t.integer  "struck_with"
    t.integer  "minute"
    t.text     "details"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.string   "city"
    t.string   "email"
    t.string   "phone"
    t.string   "position_request"
    t.string   "keeper"
    t.string   "attendance_estimate"
    t.string   "ideal_minutes"
    t.integer  "status"
    t.integer  "age"
    t.text     "why"
    t.boolean  "ebssl_card"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "team_id"
    t.integer  "user_id"
    t.boolean  "approved",            default: false
    t.integer  "jersey"
    t.integer  "position"
    t.boolean  "invited"
    t.string   "name"
    t.boolean  "has_jersey"
    t.boolean  "paid"
  end

  create_table "seasons", force: :cascade do |t|
    t.datetime "start"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "manager_id"
    t.integer  "division_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "formation_id"
    t.string   "short"
    t.string   "uniform_colors"
    t.string   "alternate_colors"
    t.string   "field_preference"
    t.string   "kick_time_preference"
    t.text     "mailing_address"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "role"
    t.date     "dob"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "day_phone"
    t.string   "evening_phone"
    t.string   "email"
    t.string   "dl_license_no"
    t.string   "dl_issuing_state"
    t.string   "passport_no"
    t.string   "passport_country"
    t.text     "league_history"
    t.boolean  "liability_waiver_agreed"
    t.integer  "pass_id"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "license_photo_file_name"
    t.string   "license_photo_content_type"
    t.integer  "license_photo_file_size"
    t.datetime "license_photo_updated_at"
    t.boolean  "manager_confirmation"
    t.string   "manager_signature"
    t.date     "manager_signature_date"
  end

end
