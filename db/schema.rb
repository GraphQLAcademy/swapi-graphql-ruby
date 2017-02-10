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

ActiveRecord::Schema.define(version: 20170210214836) do

  create_table "people", force: :cascade do |t|
    t.string   "name"
    t.string   "birth_year"
    t.string   "eye_color"
    t.string   "gender"
    t.string   "hair_color"
    t.integer  "height"
    t.integer  "mass"
    t.string   "skin_color"
    t.integer  "homeworld_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "species_id"
    t.index ["homeworld_id"], name: "index_people_on_homeworld_id"
    t.index ["species_id"], name: "index_people_on_species_id"
  end

  create_table "people_starships", id: false, force: :cascade do |t|
    t.integer "starship_id", null: false
    t.integer "person_id",   null: false
    t.index ["person_id"], name: "index_people_starships_on_person_id"
    t.index ["starship_id"], name: "index_people_starships_on_starship_id"
  end

  create_table "people_vehicles", id: false, force: :cascade do |t|
    t.integer "vehicle_id", null: false
    t.integer "person_id",  null: false
    t.index ["person_id"], name: "index_people_vehicles_on_person_id"
    t.index ["vehicle_id"], name: "index_people_vehicles_on_vehicle_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string   "name"
    t.integer  "diameter"
    t.integer  "rotation_period"
    t.integer  "orbital_period"
    t.string   "gravity"
    t.float    "population"
    t.string   "climate"
    t.string   "terrain"
    t.float    "surface_water"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "species", force: :cascade do |t|
    t.string   "name"
    t.string   "classification"
    t.string   "designation"
    t.float    "average_height"
    t.integer  "average_lifespan"
    t.string   "eye_colors"
    t.string   "hair_colors"
    t.string   "skin_colors"
    t.string   "language"
    t.integer  "homeworld_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["homeworld_id"], name: "index_species_on_homeworld_id"
  end

  create_table "starships", force: :cascade do |t|
    t.string   "name"
    t.string   "model"
    t.string   "starship_class"
    t.string   "manufacturer"
    t.float    "cost_in_credits"
    t.float    "length"
    t.string   "crew"
    t.string   "passengers"
    t.integer  "max_atmosphering_speed"
    t.float    "hyperdrive_rating"
    t.integer  "mglt"
    t.float    "cargo_capacity"
    t.string   "consumables"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "name"
    t.string   "model"
    t.string   "vehicle_class"
    t.string   "manufacturer"
    t.float    "cost_in_credits"
    t.float    "length"
    t.string   "crew"
    t.string   "passengers"
    t.integer  "max_atmosphering_speed"
    t.float    "cargo_capacity"
    t.string   "consumables"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
