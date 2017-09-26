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

ActiveRecord::Schema.define(version: 20160825042937) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "employees", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.boolean  "employed?"
    t.integer  "user_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["job_id"], name: "index_employees_on_job_id", using: :btree
    t.index ["user_id"], name: "index_employees_on_user_id", using: :btree
  end

  create_table "gfolders", force: :cascade do |t|
    t.string   "name"
    t.string   "google_id"
    t.integer  "google_oauth_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["google_oauth_id"], name: "index_gfolders_on_google_oauth_id", using: :btree
  end

  create_table "google_oauths", force: :cascade do |t|
    t.string   "refresh_token"
    t.string   "username"
    t.integer  "service_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "googlesubscriptions", force: :cascade do |t|
    t.integer  "gfolder_id"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gfolder_id"], name: "index_googlesubscriptions_on_gfolder_id", using: :btree
    t.index ["job_id"], name: "index_googlesubscriptions_on_job_id", using: :btree
  end

  create_table "jobs", force: :cascade do |t|
    t.string   "position"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_jobs_on_user_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.boolean  "supported?"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "servicesubscriptions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_servicesubscriptions_on_service_id", using: :btree
    t.index ["user_id"], name: "index_servicesubscriptions_on_user_id", using: :btree
  end

  create_table "slackbots", force: :cascade do |t|
    t.text     "authenticity_token"
    t.integer  "user_id"
    t.integer  "service_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "name"
    t.index ["service_id"], name: "index_slackbots_on_service_id", using: :btree
    t.index ["user_id"], name: "index_slackbots_on_user_id", using: :btree
  end

  create_table "slackchannels", force: :cascade do |t|
    t.boolean  "public?"
    t.string   "name"
    t.string   "slack_id"
    t.integer  "slackbot_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["slackbot_id"], name: "index_slackchannels_on_slackbot_id", using: :btree
  end

  create_table "slacksubscriptions", force: :cascade do |t|
    t.integer  "slackchannel_id"
    t.integer  "job_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["job_id"], name: "index_slacksubscriptions_on_job_id", using: :btree
    t.index ["slackchannel_id"], name: "index_slacksubscriptions_on_slackchannel_id", using: :btree
  end

  create_table "trellobots", force: :cascade do |t|
    t.text     "authenticity_key"
    t.text     "authenticity_token"
    t.string   "username"
    t.integer  "service_id"
    t.integer  "user_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["service_id"], name: "index_trellobots_on_service_id", using: :btree
    t.index ["user_id"], name: "index_trellobots_on_user_id", using: :btree
  end

  create_table "trellosubscriptions", force: :cascade do |t|
    t.integer  "trelloteam_id"
    t.integer  "job_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["job_id"], name: "index_trellosubscriptions_on_job_id", using: :btree
    t.index ["trelloteam_id"], name: "index_trellosubscriptions_on_trelloteam_id", using: :btree
  end

  create_table "trelloteams", force: :cascade do |t|
    t.string   "name"
    t.string   "trello_id"
    t.integer  "trellobot_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["trellobot_id"], name: "index_trelloteams_on_trellobot_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["remember_token"], name: "index_users_on_remember_token", using: :btree
  end

end
