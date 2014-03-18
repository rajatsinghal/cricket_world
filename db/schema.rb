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

ActiveRecord::Schema.define(version: 20140318105817) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "league_statuses", force: true do |t|
    t.integer  "league_id"
    t.integer  "team_id"
    t.integer  "matches_played",                          default: 0
    t.integer  "position",                                default: 0
    t.integer  "wins",                                    default: 0
    t.integer  "losses",                                  default: 0
    t.integer  "ties",                                    default: 0
    t.integer  "points",                                  default: 0
    t.decimal  "run_rate",       precision: 10, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_innings", force: true do |t|
    t.integer  "match_id"
    t.integer  "team_id"
    t.integer  "number"
    t.integer  "wides"
    t.integer  "no_balls"
    t.integer  "byes"
    t.integer  "leg_byes"
    t.integer  "runs"
    t.integer  "balls"
    t.integer  "wickets"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "match_performances", force: true do |t|
    t.integer  "match_id"
    t.integer  "team_id"
    t.integer  "player_id"
    t.integer  "batting_position"
    t.integer  "runs_scored"
    t.integer  "balls_faced"
    t.integer  "fours"
    t.integer  "sixes"
    t.boolean  "out"
    t.integer  "out_bowler_id"
    t.integer  "out_fielder_id"
    t.string   "mode_of_dismissal"
    t.integer  "bowling_position"
    t.integer  "balls_bowled"
    t.integer  "wickets"
    t.integer  "runs_conceded"
    t.integer  "maiden_overs"
    t.integer  "catches"
    t.integer  "stumpings"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_players", force: true do |t|
    t.integer  "match_id"
    t.integer  "team_id"
    t.integer  "player_id"
    t.boolean  "is_captain"
    t.boolean  "is_wicket_keeper"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type"
  end

  create_table "match_results", force: true do |t|
    t.integer  "match_id"
    t.integer  "toss_winner_team_id"
    t.string   "toss_choice"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", force: true do |t|
    t.integer  "home_team_id"
    t.integer  "away_team_id"
    t.datetime "start_time"
    t.string   "stadium_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.text     "description"
  end

  create_table "players", force: true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_managers", force: true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "admin_user_id"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "phone_number"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.integer  "admin_user_id"
    t.string   "age"
    t.string   "height"
    t.string   "batting_style"
    t.string   "bowling_style"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
