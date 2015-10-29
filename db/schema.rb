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

ActiveRecord::Schema.define(version: 20150923102035) do

  create_table "Accounts", force: :cascade do |t|
    t.string   "email_addr",   limit: 255
    t.string   "ssl_name",     limit: 255
    t.string   "hs_pwd",       limit: 255
    t.string   "pwd",          limit: 255
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "country",      limit: 255
    t.string   "pemail",       limit: 255
    t.string   "number",       limit: 255
    t.string   "account_type", limit: 255
    t.boolean  "is_cticket",   limit: 1
    t.boolean  "is_rticket",   limit: 1
    t.boolean  "is_dticket",   limit: 1
    t.boolean  "is_cdevice",   limit: 1
    t.boolean  "is_rdevice",   limit: 1
    t.boolean  "is_mdevice",   limit: 1
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.boolean  "is_caccount",  limit: 1
    t.boolean  "is_maccount",  limit: 1
    t.boolean  "is_daccount",  limit: 1
    t.boolean  "is_ccustomer", limit: 1
    t.boolean  "is_rcustomer", limit: 1
    t.boolean  "is_mcustomer", limit: 1
  end

  create_table "Comments", force: :cascade do |t|
    t.string   "comment",      limit: 255
    t.string   "ticket_id",    limit: 255
    t.string   "ticket_owner", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "Customers", force: :cascade do |t|
    t.string   "username",     limit: 255
    t.string   "password",     limit: 255
    t.boolean  "is_rticket",   limit: 1
    t.boolean  "is_wticket",   limit: 1
    t.boolean  "is_dticket",   limit: 1
    t.boolean  "is_sticket",   limit: 1
    t.boolean  "is_cdevice",   limit: 1
    t.boolean  "is_rdevice",   limit: 1
    t.boolean  "is_mdevice",   limit: 1
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "country",      limit: 255
    t.string   "pemail",       limit: 255
    t.string   "number",       limit: 255
    t.string   "account_type", limit: 255
  end

  create_table "Device_Users", force: :cascade do |t|
    t.string   "username",    limit: 255
    t.string   "password",    limit: 255
    t.string   "device_name", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "Devices", force: :cascade do |t|
    t.string   "owner",            limit: 255
    t.string   "name",             limit: 255
    t.string   "device_type",      limit: 255
    t.string   "location",         limit: 255
    t.string   "public_ip",        limit: 255
    t.string   "private_ip",       limit: 255
    t.string   "device_note",      limit: 255
    t.string   "addons",           limit: 255
    t.string   "general_status",   limit: 255
    t.string   "general_reloaded", limit: 255
    t.string   "osname",           limit: 255
    t.string   "osram",            limit: 255
    t.string   "osprocessor",      limit: 255
    t.string   "detail",           limit: 255
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "Dnotes", force: :cascade do |t|
    t.string   "device_id",     limit: 255
    t.string   "device_name",   limit: 255
    t.string   "device_status", limit: 255
    t.string   "request_order", limit: 255
    t.string   "is_checked",    limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "Pcustomers", force: :cascade do |t|
    t.string   "username",     limit: 255
    t.string   "password",     limit: 255
    t.boolean  "is_rticket",   limit: 1
    t.boolean  "is_wticket",   limit: 1
    t.boolean  "is_dticket",   limit: 1
    t.boolean  "is_sticket",   limit: 1
    t.boolean  "is_cdevice",   limit: 1
    t.boolean  "is_rdevice",   limit: 1
    t.boolean  "is_mdevice",   limit: 1
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "country",      limit: 255
    t.string   "pemail",       limit: 255
    t.string   "number",       limit: 255
    t.string   "account_type", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "Sadmins", force: :cascade do |t|
    t.string   "username",     limit: 255
    t.string   "password",     limit: 255
    t.string   "email",        limit: 255
    t.boolean  "is_rticket",   limit: 1
    t.boolean  "is_cticket",   limit: 1
    t.boolean  "is_dticket",   limit: 1
    t.boolean  "is_cdevice",   limit: 1
    t.boolean  "is_rdevice",   limit: 1
    t.boolean  "is_mdevice",   limit: 1
    t.boolean  "is_caccount",  limit: 1
    t.boolean  "is_maccount",  limit: 1
    t.boolean  "is_daccount",  limit: 1
    t.boolean  "is_ccustomer", limit: 1
    t.boolean  "is_rcustomer", limit: 1
    t.boolean  "is_mcustomer", limit: 1
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "country",      limit: 255
    t.string   "pemail",       limit: 255
    t.string   "number",       limit: 255
    t.string   "account_type", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "Scustomers", force: :cascade do |t|
    t.string   "username",     limit: 255
    t.string   "password",     limit: 255
    t.boolean  "is_rticket",   limit: 1
    t.boolean  "is_wticket",   limit: 1
    t.boolean  "is_dticket",   limit: 1
    t.boolean  "is_sticket",   limit: 1
    t.boolean  "is_cdevice",   limit: 1
    t.boolean  "is_rdevice",   limit: 1
    t.boolean  "is_mdevice",   limit: 1
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "country",      limit: 255
    t.string   "pemail",       limit: 255
    t.string   "number",       limit: 255
    t.string   "account_type", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "Thistories", force: :cascade do |t|
    t.string   "comment",      limit: 255
    t.string   "ticket_id",    limit: 255
    t.string   "ticket_owner", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "Tickets", force: :cascade do |t|
    t.integer  "device_id",    limit: 4
    t.string   "ticket_group", limit: 255
    t.string   "subject",      limit: 255
    t.string   "owner",        limit: 255
    t.string   "last_replied", limit: 255
    t.string   "device",       limit: 255
    t.string   "updated",      limit: 255
    t.integer  "user_id",      limit: 4
    t.boolean  "is_read",      limit: 1
    t.string   "detail",       limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "Users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",               limit: 255
    t.string   "pwd",                    limit: 255
    t.boolean  "is_rticket",             limit: 1
    t.boolean  "is_cticket",             limit: 1
    t.boolean  "is_dticket",             limit: 1
    t.boolean  "is_cdevice",             limit: 1
    t.boolean  "is_rdevice",             limit: 1
    t.boolean  "is_mdevice",             limit: 1
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.string   "city",                   limit: 255
    t.string   "state",                  limit: 255
    t.string   "country",                limit: 255
    t.string   "pemail",                 limit: 255
    t.string   "number",                 limit: 255
    t.string   "account_type",           limit: 255
    t.boolean  "is_caccount",            limit: 1
    t.boolean  "is_maccount",            limit: 1
    t.boolean  "is_daccount",            limit: 1
    t.boolean  "is_ccustomer",           limit: 1
    t.boolean  "is_mcustomer",           limit: 1
    t.boolean  "is_dcustomer",           limit: 1
  end

  add_index "users", ["email"], name: "index_Users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_Users_on_reset_password_token", unique: true, using: :btree

  create_table "Verifieds", force: :cascade do |t|
    t.string   "username",     limit: 255
    t.string   "password",     limit: 255
    t.string   "email",        limit: 255
    t.boolean  "is_rticket",   limit: 1
    t.boolean  "is_cticket",   limit: 1
    t.boolean  "is_dticket",   limit: 1
    t.boolean  "is_cdevice",   limit: 1
    t.boolean  "is_rdevice",   limit: 1
    t.boolean  "is_mdevice",   limit: 1
    t.string   "first_name",   limit: 255
    t.string   "last_name",    limit: 255
    t.string   "city",         limit: 255
    t.string   "state",        limit: 255
    t.string   "country",      limit: 255
    t.string   "pemail",       limit: 255
    t.string   "number",       limit: 255
    t.string   "account_type", limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.boolean  "is_caccount",  limit: 1
    t.boolean  "is_maccount",  limit: 1
    t.boolean  "is_daccount",  limit: 1
    t.boolean  "is_ccustomer", limit: 1
    t.boolean  "is_dcustomer", limit: 1
    t.boolean  "is_mcustomer", limit: 1
  end

  create_table "Visitors", force: :cascade do |t|
    t.string   "ip_address",  limit: 255
    t.string   "visit_count", limit: 255
    t.string   "username",    limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

end
