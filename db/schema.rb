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

ActiveRecord::Schema.define(version: 20150317065218) do

  create_table "customers", force: :cascade do |t|
    t.string "firstname", limit: 255
    t.string "lastname",  limit: 255
    t.string "email",     limit: 255
    t.string "password",  limit: 255
  end

  create_table "order_lines", force: :cascade do |t|
    t.integer "order_id",    limit: 4
    t.integer "product_id",  limit: 4
    t.integer "qty",         limit: 4
    t.float   "unit_price",  limit: 24
    t.float   "total_price", limit: 24
  end

  create_table "orders", force: :cascade do |t|
    t.string   "order_no",    limit: 255
    t.integer  "customer_id", limit: 4
    t.float    "total",       limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: :cascade do |t|
    t.string  "name",        limit: 255
    t.float   "price",       limit: 24
    t.integer "status",      limit: 4
    t.string  "description", limit: 255
  end

end
