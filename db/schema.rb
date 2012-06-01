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

ActiveRecord::Schema.define(:version => 20120601151256) do

  create_table "days", :force => true do |t|
    t.integer "member_id",    :null => false
    t.integer "number",       :null => false
    t.date    "published_on"
  end

  create_table "entries", :force => true do |t|
    t.string   "short_id",     :limit => 32
    t.integer  "day_id"
    t.string   "link",         :limit => 128
    t.string   "author",       :limit => 64
    t.boolean  "generated",                   :default => false
    t.datetime "published_at"
  end

  add_index "entries", ["day_id"], :name => "index_entries_on_day_id"

  create_table "followers", :force => true do |t|
    t.integer  "day_id"
    t.integer  "author_id"
    t.datetime "published_at"
  end

  add_index "followers", ["day_id"], :name => "index_followers_on_day_id"

  create_table "following_authors", :force => true do |t|
    t.integer  "following_id"
    t.integer  "author_id"
    t.datetime "created_at"
  end

  add_index "following_authors", ["following_id"], :name => "index_following_authors_on_following_id"

  create_table "followings", :force => true do |t|
    t.integer  "day_id"
    t.integer  "user_id"
    t.datetime "created_at"
  end

  add_index "followings", ["day_id"], :name => "index_followings_on_day_id"

  create_table "members", :force => true do |t|
    t.string   "email",               :limit => 128,                :null => false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",  :limit => 32
    t.string   "last_sign_in_ip",     :limit => 32
    t.string   "login",               :limit => 128,                :null => false
    t.string   "token",               :limit => 32
    t.string   "etag",                :limit => 32
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",      :limit => 64
  end

  add_index "members", ["email"], :name => "index_members_on_email", :unique => true

  create_table "repositories", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.string   "fullname",    :limit => 128, :null => false
    t.string   "description", :limit => 512
    t.string   "homepage"
    t.string   "language",    :limit => 16
    t.integer  "watchers"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",        :limit => 64
    t.string   "name",         :limit => 64
    t.string   "company",      :limit => 64
    t.string   "blog",         :limit => 128
    t.string   "location",     :limit => 64
    t.integer  "public_repos"
    t.integer  "followers"
    t.integer  "following"
    t.string   "avatar_url"
    t.string   "gravatar_id",  :limit => 32
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "watcher_authors", :force => true do |t|
    t.integer  "watcher_id"
    t.integer  "author_id"
    t.datetime "created_at"
  end

  create_table "watchers", :force => true do |t|
    t.integer  "day_id"
    t.integer  "repository_id"
    t.datetime "published_at"
  end

  add_index "watchers", ["day_id"], :name => "index_watchers_on_day_id"

  create_table "watching_authors", :force => true do |t|
    t.integer  "watching_id"
    t.integer  "author_id"
    t.datetime "created_at"
  end

  add_index "watching_authors", ["watching_id"], :name => "index_watching_authors_on_watching_id"

  create_table "watchings", :force => true do |t|
    t.integer  "day_id"
    t.integer  "repository_id"
    t.datetime "created_at"
  end

  add_index "watchings", ["day_id"], :name => "index_watchings_on_day_id"

end
