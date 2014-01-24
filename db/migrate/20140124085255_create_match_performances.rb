class CreateMatchPerformances < ActiveRecord::Migration
  def change
    create_table :match_performances do |t|
      t.integer :match_id
      t.integer :team_id
      t.integer :player_id
      t.integer :batting_position
      t.integer :runs_scored
      t.integer :balls_faced
      t.integer :fours
      t.integer :sixes
      t.boolean :out
      t.integer :out_bowler_id
      t.integer :out_fielder_id
      t.string :mode_of_dismissal
      t.integer :bowling_position
      t.integer :balls_bowled
      t.integer :wickets
      t.integer :runs_conceded
      t.integer :maiden_overs
      t.integer :catches
      t.integer :stumpings

      t.timestamps
    end
  end
end
