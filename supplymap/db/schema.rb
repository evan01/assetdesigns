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

ActiveRecord::Schema.define(version: 20180306024054) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.text "description"
    t.bigint "supply_chain_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["supply_chain_id"], name: "index_products_on_supply_chain_id"
  end

  create_table "shops", force: :cascade do |t|
    t.string "shopify_domain", null: false
    t.string "shopify_token", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shopify_domain"], name: "index_shops_on_shopify_domain", unique: true
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.string "product_kind"
    t.text "description"
    t.bigint "supply_chain_id"
    t.decimal "lattitude"
    t.decimal "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order"
    t.index ["name"], name: "index_suppliers_on_name"
    t.index ["supply_chain_id"], name: "index_suppliers_on_supply_chain_id"
  end

  create_table "supply_chains", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_supply_chains_on_name"
  end

  add_foreign_key "products", "supply_chains"
  add_foreign_key "suppliers", "supply_chains"
end
