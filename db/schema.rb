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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160809081202) do

  create_table "tasks", id: false, force: :cascade do |t|
    t.string   "id",              null: false
    t.datetime "created_at",      null: false
    t.datetime "modified_at"
    t.string   "name"
    t.text     "notes"
    t.boolean  "completed"
    t.string   "assignee_status"
    t.datetime "completed_at"
    t.datetime "due_on"
    t.datetime "due_at"
    t.string   "workspace_id"
    t.integer  "num_hearts"
    t.string   "assignee_id"
    t.string   "parent_id"
    t.boolean  "hearted"
    t.datetime "updated_at",      null: false
    t.index ["assignee_id"], name: "index_tasks_on_assignee_id"
    t.index ["id"], name: "index_tasks_on_id", unique: true
    t.index ["parent_id"], name: "index_tasks_on_parent_id"
    t.index ["workspace_id"], name: "index_tasks_on_workspace_id"
  end

  create_table "users", id: false, force: :cascade do |t|
    t.string   "id",         null: false
    t.string   "name"
    t.string   "email"
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_users_on_id", unique: true
  end

end
