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

ActiveRecord::Schema.define(:version => 20150425002905) do

  create_table "courses", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
    t.string   "year"
    t.string   "department"
    t.string   "semester"
  end

  create_table "enrollments", :force => true do |t|
    t.integer  "course_id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "field_responses", :force => true do |t|
    t.string   "response"
    t.integer  "survey_field_id"
    t.integer  "submission_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "participants", :force => true do |t|
    t.string   "email"
    t.integer  "survey_template_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "submissions", :force => true do |t|
    t.integer  "survey_template_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "survey_fields", :force => true do |t|
    t.string   "type"
    t.integer  "survey_template_id"
    t.string   "question_title"
    t.string   "question_description"
    t.string   "field_options"
    t.string   "survey_fields"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.boolean  "required"
    t.float    "question_weight"
  end

  create_table "survey_templates", :force => true do |t|
    t.string   "survey_title"
    t.string   "survey_description"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "course_id"
    t.string   "status"
    t.integer  "user_id"
    t.boolean  "public"
  end

  add_index "survey_templates", ["course_id"], :name => "index_survey_templates_on_course_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "status"
  end

end
