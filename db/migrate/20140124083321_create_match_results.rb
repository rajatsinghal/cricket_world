class CreateMatchResults < ActiveRecord::Migration
  def change
    create_table :match_results do |t|
      t.integer :match_id
      t.integer :toss_winner_team_id
      t.string :toss_choice

      t.timestamps
    end
  end
end
