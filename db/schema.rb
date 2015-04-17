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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150403053733) do

  create_table "availabilities", :force => true do |t|
    t.integer "preferred"
    t.integer "maybe"
  end

  create_table "shifts", :force => true do |t|
    t.datetime "shiftstart"
    t.datetime "shiftend"
    t.string   "users",          :default => " "
    t.string   "possible_users", :default => " "
    t.string   "owner",          :default => "***"
    t.string   "event_id"
    t.boolean  "ingcal",         :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "usertype"
    t.string   "username"
    t.string   "password"
    t.string   "email"
    t.string   "auth_token"
    t.float    "fte"
    t.string   "encrypted_password"
    t.boolean  "verified",               :default => false
    t.float    "fte_multiplier",         :default => 1.0
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

end
