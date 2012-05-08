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

ActiveRecord::Schema.define(:version => 20120507043010) do

  create_table "entries", :force => true do |t|
    t.string   "short_id",     :limit => 32
    t.integer  "user_id"
    t.string   "link",         :limit => 64
    t.string   "title",        :limit => 128,  :null => false
    t.string   "author_name",  :limit => 16
    t.string   "author_email", :limit => 32
    t.string   "author_uri",   :limit => 64
    t.string   "content",      :limit => 1024
    t.datetime "created_at"
  end

  add_index "entries", ["short_id"], :name => "index_entries_on_short_id", :unique => true
  add_index "entries", ["user_id"], :name => "index_entries_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",               :limit => 128, :default => "", :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",  :limit => 32
    t.string   "last_sign_in_ip",     :limit => 32
    t.string   "login",               :limit => 128,                 :null => false
    t.string   "token",               :limit => 32
    t.string   "etag",                :limit => 32
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
