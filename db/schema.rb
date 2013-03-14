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

ActiveRecord::Schema.define(version: 20130314012017) do

  create_table "cigar_stocks", force: true do |t|
    t.string   "cigar",          null: false
    t.boolean  "carried",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "cigar_store_id", null: false
  end

  add_index "cigar_stocks", ["cigar"], name: "index_cigar_stocks_on_cigar"
  add_index "cigar_stocks", ["cigar_store_id", "cigar"], name: "index_cigar_stocks_on_cigar_store_id_and_cigar", unique: true
  add_index "cigar_stocks", ["cigar_store_id"], name: "index_cigar_stocks_on_cigar_store_id"

  create_table "cigar_stores", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
