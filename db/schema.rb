# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_07_201029) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "consignments", force: :cascade do |t|
    t.string "company_code"
    t.string "reference"
    t.integer "parcels"
    t.integer "pallets"
    t.integer "bundles"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "customer_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "customer_code"
    t.string "company_name"
    t.string "address1"
    t.string "address2"
    t.string "address3"
    t.string "county"
    t.string "eircode"
    t.integer "user_id"
    t.integer "consignment_id"
    t.integer "consignments_count"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
