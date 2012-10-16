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

ActiveRecord::Schema.define(:version => 20121015073959) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

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

  create_table "initiatives", :force => true do |t|
    t.string   "title"
    t.integer  "member_id"
    t.text     "description"
    t.string   "summary_by"
    t.string   "original_document_url"
    t.datetime "presented_at"
    t.integer  "views_count",           :default => 0
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "other_sponsor"
    t.integer  "sponsors_count",        :default => 0
  end

  add_index "initiatives", ["member_id"], :name => "index_initiatives_on_member_id"

  create_table "initiatives_members", :id => false, :force => true do |t|
    t.integer "initiative_id"
    t.integer "member_id"
  end

  add_index "initiatives_members", ["initiative_id"], :name => "index_initiatives_members_on_initiative_id"
  add_index "initiatives_members", ["member_id"], :name => "index_initiatives_members_on_member_id"

  create_table "initiatives_subjects", :id => false, :force => true do |t|
    t.integer "initiative_id"
    t.integer "subject_id"
  end

  add_index "initiatives_subjects", ["initiative_id"], :name => "index_initiatives_subjects_on_initiative_id"
  add_index "initiatives_subjects", ["subject_id"], :name => "index_initiatives_subjects_on_subject_id"

  create_table "members", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "party_id"
    t.string   "comission"
    t.integer  "state_id"
    t.string   "election_type"
    t.string   "birthplace"
    t.datetime "birthdate"
    t.string   "substitute"
    t.text     "education"
    t.text     "political_experience"
    t.text     "private_experience"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "twitter"
    t.string   "facebook"
  end

  add_index "members", ["party_id"], :name => "index_members_on_party_id"
  add_index "members", ["state_id"], :name => "index_members_on_state_id"

  create_table "parties", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "initiatives_count", :default => 0
  end

end
