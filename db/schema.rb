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

ActiveRecord::Schema.define(version: 20180329230715) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "rois", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "telephone"
    t.string "priority"
    t.integer "product_types"
    t.integer "field_technicians"
    t.float "visits_per_day_per_technician"
    t.integer "profit_from_additional_truck_rolls"
    t.integer "eliminated_costs_from_return_visits"
    t.integer "total_annual_savings"
    t.integer "savings_per_service_tech"
    t.float "monthly_pricing_per_service_tech"
    t.uuid "uuid"
    t.integer "total_roi"
    t.integer "payback_achieved"
    t.string "company"
    t.boolean "meeting_requested", default: false
  end

end
