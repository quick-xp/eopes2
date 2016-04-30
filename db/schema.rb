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

ActiveRecord::Schema.define(version: 0) do

  create_table "estimate_blueprints", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.integer  "type_id"
    t.integer  "me"
    t.integer  "te"
    t.integer  "runs"
    t.integer  "estimate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_blueprints", ["estimate_id"], name: "index_estimate_blueprints_on_estimate_id", using: :btree

  create_table "estimate_job_costs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.integer  "region_id"
    t.integer  "solar_system_id"
    t.decimal  "system_cost_index", precision: 20, scale: 16
    t.decimal  "base_job_cost",     precision: 20, scale: 4
    t.decimal  "job_fee",           precision: 20, scale: 4
    t.decimal  "facility_cost",     precision: 20, scale: 4
    t.decimal  "total_job_cost",    precision: 20, scale: 4
    t.integer  "estimate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_job_costs", ["estimate_id"], name: "index_estimate_job_costs_on_estimate_id", using: :btree

  create_table "estimate_materials", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.integer  "type_id"
    t.integer  "require_count"
    t.integer  "base_quantity"
    t.decimal  "price",                  precision: 20, scale: 4
    t.decimal  "adjusted_price",         precision: 20, scale: 4
    t.decimal  "total_price",            precision: 20, scale: 4
    t.decimal  "jita_total_price",       precision: 20, scale: 4
    t.decimal  "jita_average_price",     precision: 20, scale: 4
    t.decimal  "universe_total_price",   precision: 20, scale: 4
    t.decimal  "universe_average_price", precision: 20, scale: 4
    t.decimal  "volume",                 precision: 20, scale: 4
    t.decimal  "total_volume",           precision: 20, scale: 4
    t.integer  "estimate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "estimate_materials", ["estimate_id"], name: "index_estimate_materials_on_estimate_id", using: :btree

  create_table "estimates", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.integer  "type_id"
    t.integer  "user_id"
    t.decimal  "sell_price",          precision: 20, scale: 4
    t.integer  "sell_count"
    t.integer  "product_type_id"
    t.decimal  "total_cost",          precision: 20, scale: 4
    t.decimal  "sell_total_price",    precision: 20, scale: 4
    t.decimal  "material_total_cost", precision: 20, scale: 4
    t.decimal  "profit",              precision: 20, scale: 4
    t.decimal  "total_volume",        precision: 20, scale: 4
    t.integer  "production_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "industry_systems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.integer  "solar_system_id"
    t.decimal  "cost_index",      precision: 20, scale: 16
    t.integer  "activity_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "map_jumps", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.integer "from_solar_system_id"
    t.integer "to_solar_system_id"
    t.integer "jump"
  end

  add_index "map_jumps", ["from_solar_system_id", "to_solar_system_id"], name: "index_map_jumps_on_from_solar_system_id_and_to_solar_system_id", using: :btree

  create_table "market_prices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.integer  "type_id"
    t.decimal  "adjusted_price", precision: 20, scale: 4
    t.decimal  "average_price",  precision: 20, scale: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markets", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.integer  "type_id"
    t.integer  "region_id"
    t.integer  "station_id"
    t.integer  "volume"
    t.boolean  "buy"
    t.decimal  "price",      precision: 10
    t.integer  "duration"
    t.datetime "issued"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_skills", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.integer  "skill_level"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT" do |t|
    t.string   "email"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "token"
    t.string   "refresh_token"
    t.datetime "expire"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["uid"], name: "index_users_on_uid", unique: true, using: :btree

end
