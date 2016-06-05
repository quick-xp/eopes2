create_table "estimates", collate: "utf8_bin", comment: "" do |t|
  t.int "id", primary_key: true, extra: "auto_increment"
  t.int "user_id", null: true
  t.decimal "sell_price", null: true, precision: 20, scale: 4
  t.int "sell_count", null: true
  t.int "product_type_id", null: true
  t.decimal "total_cost", null: true, precision: 20, scale: 4
  t.decimal "sell_total_price", null: true, precision: 20, scale: 4
  t.decimal "material_total_cost", null: true, precision: 20, scale: 4
  t.decimal "profit", null: true, precision: 20, scale: 4
  t.decimal "total_volume", null: true, precision: 20, scale: 4
  t.int "production_time", null: true
  t.datetime "created_at", null: true
  t.datetime "updated_at", null: true
end

create_table "estimate_blueprints", collate: "utf8_bin", comment: "" do |t|
  t.int "id", primary_key: true, extra: "auto_increment"
  t.int "type_id", null: true
  t.int "me", null: true
  t.int "te", null: true
  t.int "runs", null: true
  t.int "estimate_id", null: true
  t.datetime "created_at", null: true
  t.datetime "updated_at", null: true

  t.index "estimate_id", name: "index_estimate_blueprints_on_estimate_id"
end

create_table "estimate_job_costs", collate: "utf8_bin", comment: "" do |t|
  t.int "id", primary_key: true, extra: "auto_increment"
  t.int "region_id", null: true
  t.int "solar_system_id", null: true
  t.decimal "system_cost_index", null: true, precision: 20, scale: 16
  t.decimal "base_job_cost", null: true, precision: 20, scale: 4
  t.decimal "job_fee", null: true, precision: 20, scale: 4
  t.decimal "facility_cost", null: true, precision: 20, scale: 4
  t.decimal "total_job_cost", null: true, precision: 20, scale: 4
  t.int "estimate_id", null: true
  t.datetime "created_at", null: true
  t.datetime "updated_at", null: true

  t.index "estimate_id", name: "index_estimate_job_costs_on_estimate_id"
end

create_table "estimate_materials", collate: "utf8_bin", comment: "" do |t|
  t.int "id", primary_key: true, extra: "auto_increment"
  t.int "type_id", null: true
  t.int "require_count", null: true
  t.int "base_quantity", null: true
  t.decimal "price", null: true, precision: 20, scale: 4
  t.decimal "adjusted_price", null: true, precision: 20, scale: 4
  t.decimal "total_price", null: true, precision: 20, scale: 4
  t.decimal "jita_total_price", null: true, precision: 20, scale: 4
  t.decimal "jita_average_price", null: true, precision: 20, scale: 4
  t.decimal "universe_total_price", null: true, precision: 20, scale: 4
  t.decimal "universe_average_price", null: true, precision: 20, scale: 4
  t.decimal "volume", null: true, precision: 20, scale: 4
  t.decimal "total_volume", null: true, precision: 20, scale: 4
  t.int "estimate_id", null: true
  t.datetime "created_at", null: true
  t.datetime "updated_at", null: true

  t.index "estimate_id", name: "index_estimate_materials_on_estimate_id"
end

create_table "industry_systems", collate: "utf8_bin", comment: "" do |t|
  t.int "id", primary_key: true, extra: "auto_increment"
  t.int "solar_system_id", null: true
  t.decimal "cost_index", null: true, precision: 20, scale: 16
  t.int "activity_id", null: true
  t.datetime "created_at", null: true
  t.datetime "updated_at", null: true
end

create_table "map_jumps", collate: "utf8_bin", comment: "" do |t|
  t.int "id", primary_key: true, extra: "auto_increment"
  t.int "from_solar_system_id", null: true
  t.int "to_solar_system_id", null: true
  t.int "jump", null: true

  t.index ["from_solar_system_id", "to_solar_system_id"], name: "index_map_jumps_on_from_solar_system_id_and_to_solar_system_id"
end

create_table "markets", collate: "utf8_bin", comment: "" do |t|
  t.int "id", primary_key: true, extra: "auto_increment"
  t.int "type_id", null: true
  t.int "region_id", null: true
  t.int "station_id", null: true
  t.int "volume", null: true
  t.tinyint "buy", null: true, limit: 1
  t.decimal "price", null: true, precision: 20, scale: 4
  t.int "duration", null: true
  t.datetime "issued", null: true
  t.datetime "created_at", null: true
  t.datetime "updated_at", null: true
end

create_table "market_prices", collate: "utf8_bin", comment: "" do |t|
  t.int "id", primary_key: true, extra: "auto_increment"
  t.int "type_id", null: true
  t.decimal "adjusted_price", null: true, precision: 20, scale: 4
  t.decimal "average_price", null: true, precision: 20, scale: 4
  t.datetime "created_at", null: true
  t.datetime "updated_at", null: true
end

create_table "user_skills", collate: "utf8_bin", comment: "" do |t|
  t.int "id", primary_key: true, extra: "auto_increment"
  t.int "user_id", null: true
  t.int "skill_id", null: true
  t.int "skill_level", null: true
  t.datetime "created_at"
  t.datetime "updated_at"
end
create_table 'schema_migrations', collate: 'utf8_bin', comment: '' do |t|
  t.varchar 'version'

  t.index 'version', name: 'unique_schema_migrations', unique: true
end

create_table :ar_internal_metadata, collate: :utf8_bin do |t|
  t.varchar :key
  t.varchar :value
end
