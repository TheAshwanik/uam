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

ActiveRecord::Schema.define(version: 2019_03_17_102039) do

  create_table "application_dashboard_metrics", force: :cascade do |t|
    t.datetime "capture_time"
    t.string "metric_name"
    t.string "metric_value"
    t.string "metric_description"
    t.string "component_name"
    t.string "component_type"
    t.string "metric_status"
    t.string "remarks"
    t.integer "application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_application_dashboard_metrics_on_application_id"
  end

  create_table "applications", force: :cascade do |t|
    t.string "name"
    t.integer "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["service_id"], name: "index_applications_on_service_id"
  end

  create_table "platform_dashboard_metrics", force: :cascade do |t|
    t.datetime "capture_time"
    t.string "metric_name"
    t.string "metric_value"
    t.string "metric_description"
    t.string "component_name"
    t.string "component_type"
    t.string "metric_status"
    t.string "remarks"
    t.integer "server_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["server_id"], name: "index_platform_dashboard_metrics_on_server_id"
  end

  create_table "servers", force: :cascade do |t|
    t.string "name"
    t.string "server_type"
    t.string "role"
    t.string "state"
    t.string "os"
    t.string "os_version"
    t.integer "application_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["application_id"], name: "index_servers_on_application_id"
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
    t.string "estate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
