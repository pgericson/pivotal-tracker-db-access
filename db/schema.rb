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

ActiveRecord::Schema.define(:version => 20110818152715) do

  create_table "iterations", :force => true do |t|
    t.integer  "pt_id"
    t.integer  "number"
    t.datetime "start"
    t.datetime "finish"
    t.float    "team_strength"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.integer  "pt_id"
    t.string   "name"
    t.integer  "iteration_length"
    t.string   "week_start_day"
    t.string   "point_scale"
    t.string   "velocity_scheme"
    t.integer  "current_velocity"
    t.integer  "initial_velocity"
    t.integer  "number_of_done_iterations_to_show"
    t.string   "labels"
    t.boolean  "allow_attachments"
    t.boolean  "public"
    t.boolean  "use_https"
    t.boolean  "bugs_and_chores_are_estimatable"
    t.boolean  "commit_mode"
    t.datetime "last_activity_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stories", :force => true do |t|
    t.integer  "pt_id"
    t.integer  "pt_project_id"
    t.integer  "pt_iteration_id"
    t.string   "story_type"
    t.string   "url"
    t.integer  "estimate"
    t.string   "current_state"
    t.text     "description"
    t.string   "name"
    t.string   "requested_by"
    t.string   "owned_by"
    t.datetime "pt_created_at"
    t.datetime "accepted_at"
    t.string   "labels"
    t.date     "deadline"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
