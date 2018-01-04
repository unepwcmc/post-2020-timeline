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

ActiveRecord::Schema.define(version: 20180104152221) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_organisers", force: :cascade do |t|
    t.bigint "event_id"
    t.bigint "organiser_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_event_organisers_on_event_id"
    t.index ["organiser_id"], name: "index_event_organisers_on_organiser_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", null: false
    t.date "start_date"
    t.date "end_date"
    t.string "location"
    t.string "summary", null: false
    t.string "relevance"
    t.string "outputs", null: false
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organisers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
