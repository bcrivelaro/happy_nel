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

ActiveRecord::Schema.define(version: 2019_09_21_231926) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "members", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id", "email"], name: "index_members_on_admin_id_and_email", unique: true
    t.index ["admin_id"], name: "index_members_on_admin_id"
  end

  create_table "survey_tokens", force: :cascade do |t|
    t.bigint "survey_id"
    t.string "token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["survey_id"], name: "index_survey_tokens_on_survey_id"
    t.index ["token"], name: "index_survey_tokens_on_token", unique: true
  end

  create_table "surveys", force: :cascade do |t|
    t.bigint "admin_id"
    t.string "question", null: false
    t.string "status", default: "running", null: false
    t.integer "members_count", null: false
    t.integer "answer_count", default: 0, null: false
    t.decimal "average_rating", precision: 4, scale: 2, default: "0.0", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_surveys_on_admin_id"
  end

  add_foreign_key "members", "admins"
  add_foreign_key "survey_tokens", "surveys"
  add_foreign_key "surveys", "admins"
end
