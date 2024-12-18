# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_06_26_022344) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.integer "selected_option_ids", default: [], array: true
    t.boolean "is_correct", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
  end

  create_table "diaries", force: :cascade do |t|
    t.string "diaries_title"
    t.text "diaries_content"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "direct_messages", force: :cascade do |t|
    t.text "message_content"
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_direct_messages_on_room_id"
    t.index ["user_id"], name: "index_direct_messages_on_user_id"
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "room_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notification", default: false, null: false
    t.index ["room_id"], name: "index_entries_on_room_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "image_questions", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_url"
    t.index ["question_id"], name: "index_image_questions_on_question_id"
  end

  create_table "memos", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "question_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_memos_on_question_id"
    t.index ["user_id"], name: "index_memos_on_user_id"
  end

  create_table "notebooks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notebooks_on_user_id"
  end

  create_table "options", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.text "option_text", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 0, null: false
    t.index ["question_id"], name: "index_options_on_question_id"
  end

  create_table "pages", force: :cascade do |t|
    t.bigint "notebook_id", null: false
    t.text "page_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["notebook_id"], name: "index_pages_on_notebook_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.text "post_content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "question_correct_answers", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.integer "correct_answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["question_id"], name: "index_question_correct_answers_on_question_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "question_text", null: false
    t.integer "year", null: false
    t.string "subject", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "avatar"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  create_table "wordbooks", force: :cascade do |t|
    t.string "collection"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_wordbooks_on_user_id"
  end

  create_table "words", force: :cascade do |t|
    t.bigint "wordbook_id", null: false
    t.text "term"
    t.text "definition"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["wordbook_id"], name: "index_words_on_wordbook_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "diaries", "users"
  add_foreign_key "direct_messages", "rooms"
  add_foreign_key "direct_messages", "users"
  add_foreign_key "entries", "rooms"
  add_foreign_key "entries", "users"
  add_foreign_key "image_questions", "questions"
  add_foreign_key "memos", "questions"
  add_foreign_key "memos", "users"
  add_foreign_key "notebooks", "users"
  add_foreign_key "options", "questions"
  add_foreign_key "pages", "notebooks"
  add_foreign_key "posts", "users"
  add_foreign_key "question_correct_answers", "questions"
  add_foreign_key "wordbooks", "users"
  add_foreign_key "words", "wordbooks"
end
