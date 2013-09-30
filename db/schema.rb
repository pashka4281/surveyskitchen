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

ActiveRecord::Schema.define(:version => 20130926125536) do

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

  create_table "cms_blocks", :force => true do |t|
    t.integer  "page_id",                        :null => false
    t.string   "identifier",                     :null => false
    t.text     "content",    :limit => 16777215
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "cms_blocks", ["page_id", "identifier"], :name => "index_cms_blocks_on_page_id_and_identifier"

  create_table "cms_categories", :force => true do |t|
    t.integer "site_id",          :null => false
    t.string  "label",            :null => false
    t.string  "categorized_type", :null => false
  end

  add_index "cms_categories", ["site_id", "categorized_type", "label"], :name => "index_cms_categories_on_site_id_and_categorized_type_and_label", :unique => true

  create_table "cms_categorizations", :force => true do |t|
    t.integer "category_id",      :null => false
    t.string  "categorized_type", :null => false
    t.integer "categorized_id",   :null => false
  end

  add_index "cms_categorizations", ["category_id", "categorized_type", "categorized_id"], :name => "index_cms_categorizations_on_cat_id_and_catd_type_and_catd_id", :unique => true

  create_table "cms_files", :force => true do |t|
    t.integer  "site_id",                                          :null => false
    t.integer  "block_id"
    t.string   "label",                                            :null => false
    t.string   "file_file_name",                                   :null => false
    t.string   "file_content_type",                                :null => false
    t.integer  "file_file_size",                                   :null => false
    t.string   "description",       :limit => 2048
    t.integer  "position",                          :default => 0, :null => false
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

  add_index "cms_files", ["site_id", "block_id"], :name => "index_cms_files_on_site_id_and_block_id"
  add_index "cms_files", ["site_id", "file_file_name"], :name => "index_cms_files_on_site_id_and_file_file_name"
  add_index "cms_files", ["site_id", "label"], :name => "index_cms_files_on_site_id_and_label"
  add_index "cms_files", ["site_id", "position"], :name => "index_cms_files_on_site_id_and_position"

  create_table "cms_layouts", :force => true do |t|
    t.integer  "site_id",                                           :null => false
    t.integer  "parent_id"
    t.string   "app_layout"
    t.string   "label",                                             :null => false
    t.string   "identifier",                                        :null => false
    t.text     "content",    :limit => 16777215
    t.text     "css",        :limit => 16777215
    t.text     "js",         :limit => 16777215
    t.integer  "position",                       :default => 0,     :null => false
    t.boolean  "is_shared",                      :default => false, :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "cms_layouts", ["parent_id", "position"], :name => "index_cms_layouts_on_parent_id_and_position"
  add_index "cms_layouts", ["site_id", "identifier"], :name => "index_cms_layouts_on_site_id_and_identifier", :unique => true

  create_table "cms_pages", :force => true do |t|
    t.integer  "site_id",                                               :null => false
    t.integer  "layout_id"
    t.integer  "parent_id"
    t.integer  "target_page_id"
    t.string   "label",                                                 :null => false
    t.string   "slug"
    t.string   "full_path",                                             :null => false
    t.text     "content",        :limit => 16777215
    t.integer  "position",                           :default => 0,     :null => false
    t.integer  "children_count",                     :default => 0,     :null => false
    t.boolean  "is_published",                       :default => true,  :null => false
    t.boolean  "is_shared",                          :default => false, :null => false
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
  end

  add_index "cms_pages", ["parent_id", "position"], :name => "index_cms_pages_on_parent_id_and_position"
  add_index "cms_pages", ["site_id", "full_path"], :name => "index_cms_pages_on_site_id_and_full_path"

  create_table "cms_revisions", :force => true do |t|
    t.string   "record_type",                     :null => false
    t.integer  "record_id",                       :null => false
    t.text     "data",        :limit => 16777215
    t.datetime "created_at"
  end

  add_index "cms_revisions", ["record_type", "record_id", "created_at"], :name => "index_cms_revisions_on_record_type_and_record_id_and_created_at"

  create_table "cms_sites", :force => true do |t|
    t.string  "label",                          :null => false
    t.string  "identifier",                     :null => false
    t.string  "hostname",                       :null => false
    t.string  "path"
    t.string  "locale",      :default => "en",  :null => false
    t.boolean "is_mirrored", :default => false, :null => false
  end

  add_index "cms_sites", ["hostname"], :name => "index_cms_sites_on_hostname"
  add_index "cms_sites", ["is_mirrored"], :name => "index_cms_sites_on_is_mirrored"

  create_table "cms_snippets", :force => true do |t|
    t.integer  "site_id",                                           :null => false
    t.string   "label",                                             :null => false
    t.string   "identifier",                                        :null => false
    t.text     "content",    :limit => 16777215
    t.integer  "position",                       :default => 0,     :null => false
    t.boolean  "is_shared",                      :default => false, :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
  end

  add_index "cms_snippets", ["site_id", "identifier"], :name => "index_cms_snippets_on_site_id_and_identifier", :unique => true
  add_index "cms_snippets", ["site_id", "position"], :name => "index_cms_snippets_on_site_id_and_position"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "exception_storages", :force => true do |t|
    t.string   "message"
    t.text     "trace"
    t.string   "e_class"
    t.datetime "created_at"
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
    t.text    "recipients"
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
    t.string   "items_positions"
    t.datetime "updated_at"
    t.boolean  "setup_finished",               :default => false
    t.integer  "category_id"
    t.string   "token"
    t.datetime "created_at"
    t.boolean  "active",                       :default => true
    t.string   "preview_flag",    :limit => 3
    t.integer  "theme_id"
    t.string   "type"
    t.boolean  "interactive",                  :default => false
    t.string   "submit_btn_txt"
    t.text     "passed_message"
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
    t.string   "roles"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
