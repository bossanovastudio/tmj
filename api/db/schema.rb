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

ActiveRecord::Schema.define(version: 20170224190124) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.integer  "origin"
    t.text     "content"
    t.string   "media_type"
    t.integer  "media_id"
    t.datetime "posted_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "source_url"
    t.integer  "size",                default: 1
    t.json     "social_user"
    t.string   "social_uid"
    t.integer  "remix_image_id"
    t.json     "moderation_metadata"
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

  create_table "editor_networks", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "kind"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_editor_networks_on_user_id", using: :btree
  end

  create_table "follows", force: :cascade do |t|
    t.string   "followable_type",                 null: false
    t.integer  "followable_id",                   null: false
    t.string   "follower_type",                   null: false
    t.integer  "follower_id",                     null: false
    t.boolean  "blocked",         default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["followable_id", "followable_type"], name: "fk_followables", using: :btree
    t.index ["follower_id", "follower_type"], name: "fk_follows", using: :btree
  end

  create_table "highlights", force: :cascade do |t|
    t.text     "content"
    t.datetime "posted_at"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "source_url"
    t.integer  "size",             default: 1
    t.integer  "index",            default: 0
    t.boolean  "published"
    t.integer  "desktop_image_id"
    t.integer  "mobile_image_id"
    t.index ["desktop_image_id"], name: "index_highlights_on_desktop_image_id", using: :btree
    t.index ["mobile_image_id"], name: "index_highlights_on_mobile_image_id", using: :btree
  end

  create_table "images", force: :cascade do |t|
    t.string   "file"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "width",      default: 1, null: false
    t.integer  "height",     default: 1, null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string   "slug"
    t.string   "title"
    t.string   "keywords"
    t.string   "description"
    t.text     "content"
    t.string   "background_menu"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "background_page"
    t.index ["slug"], name: "index_pages_on_slug", unique: true, using: :btree
  end

  create_table "providers", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "username"
    t.index ["user_id"], name: "index_providers_on_user_id", using: :btree
  end

  create_table "remix_background_colors", force: :cascade do |t|
    t.string   "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "remix_categories", force: :cascade do |t|
    t.string   "cover"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "remix_images", force: :cascade do |t|
    t.integer  "remix_category_id"
    t.string   "image"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["remix_category_id"], name: "index_remix_images_on_remix_category_id", using: :btree
  end

  create_table "remix_patterns", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "remix_stickers", force: :cascade do |t|
    t.string   "image"
    t.integer  "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "remix_text_colors", force: :cascade do |t|
    t.string   "foreground"
    t.string   "background"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "remix_user_images", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "image"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "uid"
    t.boolean  "is_strip",   default: false
    t.index ["user_id"], name: "index_remix_user_images_on_user_id", using: :btree
  end

  create_table "social_networks", force: :cascade do |t|
    t.string   "name"
    t.integer  "origin"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "encrypted_password",                               default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                    default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "image"
    t.string   "email"
    t.datetime "created_at",                                                    null: false
    t.datetime "updated_at",                                                    null: false
    t.string   "username",                                                      null: false
    t.integer  "role",                                             default: 1
    t.string   "mask"
    t.string   "authentication_token",                  limit: 30
    t.text     "bio"
    t.string   "editor_color"
    t.string   "editor_icon"
    t.string   "editor_desktop_background"
    t.string   "editor_mobile_background"
    t.string   "editor_menu_background"
    t.string   "editor_recommendation_ribbon"
    t.string   "editor_avatar_hover"
    t.string   "editor_recommendation_ribbon_animated"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
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

  add_foreign_key "editor_networks", "users"
  add_foreign_key "highlights", "images", column: "desktop_image_id"
  add_foreign_key "highlights", "images", column: "mobile_image_id"
  add_foreign_key "remix_images", "remix_categories"
  add_foreign_key "remix_user_images", "users"
end
