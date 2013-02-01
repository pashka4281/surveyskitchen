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

ActiveRecord::Schema.define(:version => 20130201173513) do

  create_table "accounts", :force => true do |t|
    t.string   "name"
    t.integer  "account_plan_id"
    t.string   "subdomain"
    t.integer  "owner_id"
    t.datetime "created_at"
  end

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "access_token_secret"
    t.string   "access_token"
    t.string   "linked_name"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rails_admin_histories", :force => true do |t|
    t.text     "message"
    t.string   "username"
    t.integer  "item"
    t.string   "table"
    t.integer  "month",      :limit => 2
    t.integer  "year",       :limit => 5
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "rails_admin_histories", ["item", "table", "month", "year"], :name => "index_rails_admin_histories"

  create_table "responses", :force => true do |t|
    t.integer  "survey_id"
    t.text     "user_agent_string"
    t.text     "content"
    t.string   "remote_ip"
    t.datetime "created_at"
  end

  create_table "survey_items", :force => true do |t|
    t.integer  "survey_id"
    t.text     "content"
    t.string   "type"
    t.string   "title"
    t.datetime "deleted_at"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "items_positions", :default => "'"
    t.datetime "updated_at"
    t.boolean  "setup_finished",  :default => false
    t.integer  "category_id"
    t.string   "token"
    t.datetime "created_at"
    t.boolean  "seed_item",       :default => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",           :default => "", :null => false
    t.string   "full_name"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "account_id"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
    t.boolean  "admin"
    t.string   "password_digest"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
