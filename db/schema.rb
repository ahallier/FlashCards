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


ActiveRecord::Schema.define(version: 20161116022537) do

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
    t.text     "category"
    t.boolean  "public"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "decks_groups", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "deck_id"
  end

  add_index "decks_groups", ["deck_id"], name: "index_decks_groups_on_deck_id"
  add_index "decks_groups", ["group_id"], name: "index_decks_groups_on_group_id"

  create_table "groups", force: :cascade do |t|
    t.text     "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public"
  end

  create_table "users", force: :cascade do |t|
    t.text     "email"
    t.text     "password"
    t.string   "session_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_fav_decks", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "deck_id"
  end

  add_index "users_fav_decks", ["deck_id"], name: "index_users_fav_decks_on_deck_id"
  add_index "users_fav_decks", ["user_id"], name: "index_users_fav_decks_on_user_id"

  create_table "users_groups", id: false, force: :cascade do |t|
    t.integer "users_id"
    t.integer "groups_id"
  end

  add_index "users_groups", ["groups_id"], name: "index_users_groups_on_groups_id"
  add_index "users_groups", ["users_id"], name: "index_users_groups_on_users_id"

end
