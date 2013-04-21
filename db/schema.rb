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

ActiveRecord::Schema.define(:version => 20130421021301) do

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

  create_table "blog_comments", :force => true do |t|
    t.string   "name",       :null => false
    t.string   "email",      :null => false
    t.string   "website"
    t.text     "body",       :null => false
    t.integer  "post_id",    :null => false
    t.string   "state"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "blog_comments", ["post_id"], :name => "index_blog_comments_on_post_id"

  create_table "blog_posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "author_id"
    t.text     "meta_keywords",    :limit => 500
    t.text     "meta_description", :limit => 800
    t.datetime "created_at"
    t.string   "slug"
  end

  add_index "blog_posts", ["slug"], :name => "index_blog_posts_on_slug", :unique => true

  create_table "buy_requests", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.string   "how_found"
    t.text     "text"
    t.string   "acc_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "client_lists", :force => true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "clients", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.integer  "account_id"
    t.string   "full_name"
    t.text     "note"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "eventable_type"
    t.integer  "eventable_id"
    t.integer  "account_id"
    t.string   "type"
    t.datetime "created_at"
    t.string   "eventable_name"
  end

  create_table "exception_storages", :force => true do |t|
    t.string "message"
    t.text   "trace"
    t.string "e_class"
  end

  create_table "quiz_items", :force => true do |t|
    t.integer "quiz_id"
    t.string  "type"
    t.text    "css_options"
    t.string  "size"
    t.string  "position"
    t.text    "content"
  end

  create_table "quizzes", :force => true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.integer  "user_id"
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
    t.integer  "shareable_id"
    t.string   "shareable_type"
    t.datetime "viewed_at"
  end

  create_table "share_emails", :force => true do |t|
    t.integer "survey_id"
    t.text    "text"
    t.boolean "active"
    t.string  "from_email"
    t.string  "subject"
  end

  create_table "share_embeds", :force => true do |t|
    t.integer "survey_id"
    t.boolean "active"
  end

  create_table "share_links", :force => true do |t|
    t.integer "survey_id"
    t.string  "custom_url"
    t.boolean "active"
  end

  create_table "survey_items", :force => true do |t|
    t.integer  "survey_id"
    t.text     "content"
    t.string   "type"
    t.string   "title"
    t.datetime "deleted_at"
    t.boolean  "required_field", :default => false
    t.string   "subtitle"
  end

  create_table "survey_themes", :force => true do |t|
    t.integer  "account_id"
    t.string   "name",       :limit => 50
    t.datetime "created_at"
    t.text     "content"
  end

  create_table "surveys", :force => true do |t|
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.string   "items_positions",              :default => "'"
    t.datetime "updated_at"
    t.boolean  "setup_finished",               :default => false
    t.integer  "category_id"
    t.datetime "created_at"
    t.boolean  "active",                       :default => true
    t.string   "preview_flag",    :limit => 3
    t.integer  "theme_id"
    t.string   "type"
    t.string   "token"
  end

  add_index "surveys", ["token"], :name => "index_surveys_on_token", :unique => true

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
    t.string   "language"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
