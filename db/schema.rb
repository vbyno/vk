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

ActiveRecord::Schema.define(version: 20140322140234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: true do |t|
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

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

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
    t.integer  "main_photo_id"
    t.boolean  "active",                                    default: false, null: false
    t.string   "short_description",                         default: "",    null: false
  end

  create_table "pages", force: true do |t|
    t.string   "type",                            null: false
    t.integer  "parent_id"
    t.string   "permalink",                       null: false
    t.string   "title",                           null: false
    t.string   "intro",                           null: false
    t.text     "content",                         null: false
    t.string   "locale",                          null: false
    t.boolean  "active",          default: false, null: false
    t.integer  "priority",        default: 0,     null: false
    t.string   "seo_title",                       null: false
    t.string   "seo_description"
    t.string   "seo_keywords"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "photo_translations", force: true do |t|
    t.integer "apartment_translation_id", null: false
    t.integer "photo_id",                 null: false
    t.string  "alt"
    t.string  "title"
  end

  add_index "photo_translations", ["apartment_translation_id"], name: "index_photo_translations_on_apartment_translation_id", using: :btree

  create_table "photos", force: true do |t|
    t.integer  "apartment_id", null: false
    t.string   "image",        null: false
    t.string   "title"
    t.string   "alt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "photos", ["apartment_id"], name: "index_photos_on_apartment_id", using: :btree

  create_table "pictures", force: true do |t|
    t.integer  "imageable_id",   null: false
    t.string   "imageable_type", null: false
    t.string   "image",          null: false
    t.string   "alt"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.string   "customer_phone", null: false
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
