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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170210023928) do

  create_table "blogs", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "blogs", ["user_id", "title"], name: "index_blogs_on_user_id_and_title", unique: true

  create_table "blogs_comments", id: false, force: :cascade do |t|
    t.integer "comment_id"
    t.integer "blog_id"
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type"

  create_table "comments", force: :cascade do |t|
    t.string   "title"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "upload_id"
    t.integer  "blog_id"
    t.string   "video_id"
  end

  add_index "comments", ["upload_id"], name: "index_comments_on_upload_id"
  add_index "comments", ["user_id", "title"], name: "index_comments_on_user_id_and_title", unique: true

  create_table "comments_uploads", id: false, force: :cascade do |t|
    t.integer "comment_id"
    t.integer "upload_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "title"
    t.string   "content"
    t.string   "email"
    t.string   "user"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "notice",                         null: false
    t.boolean  "active",          default: true
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "notice_type"
    t.integer  "source"
    t.string   "source_location"
    t.integer  "source_id"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id"

  create_table "reports", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.integer  "upload_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "blog_id"
    t.string   "video_id"
    t.integer  "count",      default: 0
  end

  add_index "reports", ["user_id"], name: "index_reports_on_user_id"

  create_table "reports_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "report_id"
  end

  create_table "uploads", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "zipcode"
    t.string   "title"
    t.text     "note"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "file"
    t.boolean  "save_upload",          default: false
    t.integer  "terms_and_conditions", default: 0
  end

  add_index "uploads", ["user_id", "title"], name: "index_uploads_on_user_id_and_title", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "username",                              null: false
    t.string   "email",                                 null: false
    t.integer  "zipcode"
    t.boolean  "admin",                 default: false
    t.string   "password_digest"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.boolean  "banned",                default: false
    t.text     "bio"
    t.string   "password_confirmation"
    t.integer  "uploads_id"
    t.boolean  "allow_emails"
    t.integer  "warn_level",            default: 0
  end

  add_index "users", ["id"], name: "index_users_on_id", unique: true
  add_index "users", ["uploads_id"], name: "index_users_on_uploads_id"

end
