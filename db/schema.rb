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

ActiveRecord::Schema.define(:version => 20130411090544) do

  create_table "accounts", :force => true do |t|
    t.string   "company"
    t.string   "adress1"
    t.string   "adress2"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "accounting_code"
    t.text     "notes"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.string   "category"
    t.string   "tel"
    t.string   "fax"
    t.string   "email"
    t.string   "web"
    t.integer  "origin_id"
  end

  create_table "accounts_tags", :id => false, :force => true do |t|
    t.integer "account_id", :null => false
    t.integer "tag_id",     :null => false
  end

  create_table "admin_notes", :force => true do |t|
    t.integer  "resource_id",     :null => false
    t.string   "resource_type",   :null => false
    t.integer  "admin_user_id"
    t.string   "admin_user_type"
    t.text     "body"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "admin_notes", ["admin_user_type", "admin_user_id"], :name => "index_admin_notes_on_admin_user_type_and_admin_user_id"
  add_index "admin_notes", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "admin_users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true
  add_index "admin_users", ["reset_password_token"], :name => "index_admin_users_on_reset_password_token", :unique => true

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "contacts", :force => true do |t|
    t.string   "surname"
    t.string   "forename"
    t.string   "title"
    t.string   "tel"
    t.string   "fax"
    t.string   "mobile"
    t.string   "email"
    t.string   "job"
    t.text     "notes"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "account_id"
  end

  create_table "contacts_tags", :id => false, :force => true do |t|
    t.integer "contact_id", :null => false
    t.integer "tag_id",     :null => false
  end

  create_table "documents", :force => true do |t|
    t.string   "name"
    t.text     "notes"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "account_id"
  end

  create_table "event_types", :force => true do |t|
    t.string   "label"
    t.string   "direction"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "events", :force => true do |t|
    t.datetime "date_begin"
    t.datetime "date_end"
    t.text     "notes"
    t.integer  "created_by"
    t.integer  "modified_by"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "contact_id"
    t.integer  "account_id"
    t.integer  "event_type_id"
    t.integer  "user_id"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.integer  "task_id"
    t.text     "notes2"
  end

  create_table "opportunities", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "statut"
    t.string   "remark"
    t.float    "amount"
    t.datetime "term"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "account_id"
    t.integer  "contact_id"
    t.integer  "user_id"
    t.float    "profit"
  end

  create_table "origins", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "quotation_lines", :force => true do |t|
    t.string   "ref"
    t.text     "designation"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "quotation_id"
    t.integer  "price_excl_tax_cents",    :default => 0,     :null => false
    t.string   "price_excl_tax_currency", :default => "EUR", :null => false
    t.integer  "total_excl_tax_cents",    :default => 0,     :null => false
    t.string   "total_excl_tax_currency", :default => "EUR", :null => false
    t.decimal  "quantity"
  end

  create_table "quotation_templates", :force => true do |t|
    t.string   "company"
    t.string   "adress"
    t.string   "city"
    t.integer  "zip"
    t.string   "country"
    t.string   "tel"
    t.string   "fax"
    t.string   "web"
    t.string   "email"
    t.string   "capital"
    t.string   "ape"
    t.string   "company_registration_number"
    t.string   "vat"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "quotations", :force => true do |t|
    t.string   "ref"
    t.datetime "date"
    t.string   "statut"
    t.string   "ref_account"
    t.string   "mode_reg"
    t.integer  "validity"
    t.boolean  "done"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "account_id"
    t.integer  "contact_id"
    t.integer  "user_id"
    t.integer  "opportunity_id"
    t.integer  "quotation_template_id"
    t.integer  "total_excl_tax_cents",    :default => 0,     :null => false
    t.string   "total_excl_tax_currency", :default => "EUR", :null => false
    t.integer  "total_incl_tax_cents",    :default => 0,     :null => false
    t.string   "total_incl_tax_currency", :default => "EUR", :null => false
    t.string   "company"
    t.string   "adress1"
    t.string   "adress2"
    t.string   "zip"
    t.string   "city"
    t.string   "country"
    t.string   "surname"
    t.string   "forename"
    t.string   "title"
    t.string   "job"
    t.decimal  "VAT_rate"
    t.integer  "total_VAT_cents",         :default => 0,     :null => false
    t.string   "total_VAT_currency",      :default => "EUR", :null => false
    t.string   "label"
  end

  create_table "relations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "account1_id"
    t.integer  "account2_id"
    t.integer  "created_by"
    t.integer  "updated_by"
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "tasks", :force => true do |t|
    t.text     "notes"
    t.string   "statut"
    t.datetime "created_at",          :null => false
    t.integer  "created_by"
    t.datetime "modified_at"
    t.integer  "modified_by"
    t.datetime "updated_at",          :null => false
    t.integer  "contact_id"
    t.integer  "account_id"
    t.integer  "user_id"
    t.string   "term"
    t.string   "attach_file_name"
    t.string   "attach_content_type"
    t.integer  "attach_file_size"
    t.datetime "attach_updated_at"
    t.string   "priority"
    t.string   "title"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "forename"
    t.string   "surname"
    t.string   "tel"
    t.string   "mobile"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "is_admin",               :default => false
    t.boolean  "is_super_user",          :default => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
