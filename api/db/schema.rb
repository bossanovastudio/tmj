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

ActiveRecord::Schema.define(version: 20161130205041) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer  "origin"
    t.text     "content"
    t.string   "media_type"
    t.integer  "media_id"
    t.datetime "posted_at"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "source_url"
    t.integer  "status",      default: 1
    t.integer  "size",        default: 1
    t.json     "social_user"
    t.string   "social_uid"
    t.index ["media_type", "media_id"], name: "index_cards_on_media_type_and_media_id", using: :btree
  end

  create_table "castings", force: :cascade do |t|
    t.boolean  "accept_terms"
    t.string   "adult_address"
    t.string   "adult_birthdate"
    t.string   "adult_cellphone"
    t.string   "adult_city"
    t.string   "adult_document_cpf"
    t.string   "adult_document_rg"
    t.string   "adult_email"
    t.string   "adult_name"
    t.string   "adult_neighborhood"
    t.string   "adult_phone"
    t.string   "adult_state"
    t.string   "adult_zip"
    t.string   "age"
    t.string   "birthdate"
    t.string   "document_cpf"
    t.string   "document_rg"
    t.string   "eye_color"
    t.string   "hair_color"
    t.string   "height"
    t.boolean  "instrument"
    t.string   "instrument_description"
    t.string   "name"
    t.string   "pants_size"
    t.boolean  "performance"
    t.string   "performance_description"
    t.string   "photo_face"
    t.string   "photo_body"
    t.string   "photo_upperbody"
    t.string   "shirt_size"
    t.string   "shoe_size"
    t.boolean  "singer"
    t.string   "skin_color"
    t.boolean  "sport"
    t.string   "sport_description"
    t.boolean  "theater"
    t.string   "theater_description"
    t.string   "video"
    t.string   "videopassword"
    t.string   "weight"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.boolean  "newsletter"
  end

  create_table "highlights", force: :cascade do |t|
    t.text     "content"
    t.string   "media_type"
    t.integer  "media_id"
    t.datetime "posted_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "source_url"
    t.integer  "size",              default: 1
    t.integer  "mobile_media_id"
    t.string   "mobile_media_type"
    t.index ["media_type", "media_id"], name: "index_highlights_on_media_type_and_media_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "width",      default: 1, null: false
    t.integer  "height",     default: 1, null: false
  end

  create_table "providers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_providers_on_user_id", using: :btree
  end

  create_table "social_networks", force: :cascade do |t|
    t.string   "name"
    t.integer  "origin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "provider",               default: "email", null: false
    t.string   "uid",                    default: "",      null: false
    t.string   "encrypted_password",     default: "",      null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,       null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "name"
    t.string   "nickname"
    t.string   "image"
    t.string   "email"
    t.json     "tokens"
    t.datetime "created_at",                               null: false
    t.datetime "updated_at",                               null: false
    t.string   "username",                                 null: false
    t.integer  "role"
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true, using: :btree
  end

  create_table "videos", force: :cascade do |t|
    t.string   "url"
    t.integer  "origin"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "thumbnail"
    t.integer  "width",      default: 1, null: false
    t.integer  "height",     default: 1, null: false
  end

end
