# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150809022253) do

  create_table "cards", force: :cascade do |t|
    t.integer  "deck_id"
    t.text     "front"
    t.text     "back"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cards", ["deck_id"], name: "index_cards_on_deck_id"

  create_table "decks", force: :cascade do |t|
    t.string   "title"
    t.integer  "score"
    t.text     "catergory"
    t.datetime "create_date"
    t.integer  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: :cascade do |t|
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups_decks", id: false, force: :cascade do |t|
    t.integer "groups_id"
    t.integer "decks_id"
  end

  add_index "groups_decks", ["decks_id"], name: "index_groups_decks_on_decks_id"
  add_index "groups_decks", ["groups_id"], name: "index_groups_decks_on_groups_id"

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "password"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_decks", id: false, force: :cascade do |t|
    t.integer "users_id"
    t.integer "decks_id"
  end

  add_index "users_decks", ["decks_id"], name: "index_users_decks_on_decks_id"
  add_index "users_decks", ["users_id"], name: "index_users_decks_on_users_id"

  create_table "users_groups", id: false, force: :cascade do |t|
    t.integer "users_id"
    t.integer "groups_id"
  end

  add_index "users_groups", ["groups_id"], name: "index_users_groups_on_groups_id"
  add_index "users_groups", ["users_id"], name: "index_users_groups_on_users_id"

end
