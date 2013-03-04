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

ActiveRecord::Schema.define(:version => 20130221063602) do

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

  create_table "assistances", :force => true do |t|
    t.integer  "deputy_id"
    t.integer  "session_id"
    t.integer  "value"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "assistances", ["deputy_id"], :name => "index_assistances_on_deputy_id"
  add_index "assistances", ["session_id"], :name => "index_assistances_on_session_id"

  create_table "commission_memberships", :force => true do |t|
    t.string   "position"
    t.integer  "commission_id"
    t.integer  "deputy_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "commission_memberships", ["commission_id"], :name => "index_commission_memberships_on_commission_id"
  add_index "commission_memberships", ["deputy_id"], :name => "index_commission_memberships_on_deputy_id"

  create_table "commissions", :force => true do |t|
    t.string   "name"
    t.string   "chamber"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "commissions_initiative_steps", :id => false, :force => true do |t|
    t.integer "commission_id"
    t.integer "initiative_step_id"
  end

  add_index "commissions_initiative_steps", ["commission_id", "initiative_step_id"], :name => "by_commission_id_and_initiative_step_id"

  create_table "deputies", :force => true do |t|
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
    t.string   "alternative_name"
    t.integer  "district_id"
    t.integer  "region_id"
    t.string   "twitter_widget_id"
  end

  add_index "deputies", ["district_id"], :name => "index_deputies_on_district_id"
  add_index "deputies", ["party_id"], :name => "index_deputies_on_party_id"
  add_index "deputies", ["region_id"], :name => "index_deputies_on_region_id"
  add_index "deputies", ["state_id"], :name => "index_deputies_on_state_id"

  create_table "deputies_initiatives", :id => false, :force => true do |t|
    t.integer "initiative_id"
    t.integer "deputy_id"
  end

  add_index "deputies_initiatives", ["deputy_id"], :name => "index_deputies_initiatives_on_deputy_id"
  add_index "deputies_initiatives", ["initiative_id"], :name => "index_deputies_initiatives_on_initiative_id"

  create_table "districts", :force => true do |t|
    t.integer "number",   :null => false
    t.integer "state_id", :null => false
  end

  add_index "districts", ["state_id"], :name => "index_districts_on_state_id"

  create_table "initiative_steps", :force => true do |t|
    t.integer  "initiative_id"
    t.integer  "step"
    t.date     "start"
    t.string   "chamber"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "initiative_steps", ["initiative_id"], :name => "index_initiative_steps_on_initiative_id"

  create_table "initiatives", :force => true do |t|
    t.string   "title"
    t.integer  "deputy_id"
    t.text     "description"
    t.string   "summary_by"
    t.string   "original_document_url"
    t.datetime "presented_at"
    t.integer  "views_count",           :default => 0
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.string   "other_sponsor"
    t.integer  "sponsors_count",        :default => 0
    t.string   "votes_url"
    t.boolean  "voted",                 :default => false
    t.integer  "gazette_id"
  end

  add_index "initiatives", ["deputy_id"], :name => "index_initiatives_on_deputy_id"

  create_table "initiatives_subjects", :id => false, :force => true do |t|
    t.integer "initiative_id"
    t.integer "subject_id"
  end

  add_index "initiatives_subjects", ["initiative_id"], :name => "index_initiatives_subjects_on_initiative_id"
  add_index "initiatives_subjects", ["subject_id"], :name => "index_initiatives_subjects_on_subject_id"

  create_table "parties", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "official_id"
  end

  create_table "regions", :force => true do |t|
    t.integer "number", :null => false
  end

  create_table "sections", :force => true do |t|
    t.integer "number",      :null => false
    t.integer "district_id", :null => false
  end

  add_index "sections", ["district_id"], :name => "index_sections_on_district_id"

  create_table "sessions", :force => true do |t|
    t.date    "date"
    t.integer "number"
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "short_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "region_id"
  end

  add_index "states", ["region_id"], :name => "index_states_on_region_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "initiatives_count", :default => 0
  end

  create_table "user_interests", :force => true do |t|
    t.integer "user_id"
    t.integer "subject_id"
  end

  add_index "user_interests", ["subject_id"], :name => "index_user_interests_on_subject_id"
  add_index "user_interests", ["user_id"], :name => "index_user_interests_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
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
    t.boolean  "receive_notifications"
    t.integer  "section_id"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["section_id"], :name => "index_users_on_section_id"

  create_table "votes", :force => true do |t|
    t.integer  "value",         :limit => 2
    t.integer  "initiative_id"
    t.integer  "session_id"
    t.integer  "voter_id"
    t.string   "voter_type"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  add_index "votes", ["initiative_id"], :name => "index_votes_on_initiative_id"
  add_index "votes", ["session_id"], :name => "index_votes_on_session_id"
  add_index "votes", ["value"], :name => "index_votes_on_value"
  add_index "votes", ["voter_id", "voter_type"], :name => "index_votes_on_voter_id_and_voter_type"

end
