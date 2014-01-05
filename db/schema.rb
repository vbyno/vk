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

ActiveRecord::Schema.define(version: 20140105172111) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "apartment_translations", force: true do |t|
    t.string   "locale",                         null: false
    t.string   "title",                          null: false
    t.text     "description",                    null: false
    t.integer  "apartment_id",                   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_description", default: "", null: false
  end

  add_index "apartment_translations", ["apartment_id"], name: "index_apartment_translations_on_apartment_id", using: :btree

  create_table "apartments", force: true do |t|
    t.string   "title",                                                     null: false
    t.decimal  "price",             precision: 6, scale: 2,                 null: false
    t.text     "description",                                               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "main_image_id"
    t.boolean  "active",                                    default: false, null: false
    t.string   "short_description",                         default: "",    null: false
  end

  create_table "gallery_images", force: true do |t|
    t.integer  "apartment_id", null: false
    t.string   "image",        null: false
    t.string   "title"
    t.string   "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gallery_images", ["apartment_id"], name: "index_gallery_images_on_apartment_id", using: :btree

  create_table "reservations", force: true do |t|
    t.integer  "apartment_id",   null: false
    t.string   "customer_name",  null: false
    t.string   "customer_email", null: false
    t.datetime "check_in",       null: false
    t.datetime "check_out",      null: false
    t.string   "status",         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "body"
  end

  add_index "reservations", ["apartment_id"], name: "index_reservations_on_apartment_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
