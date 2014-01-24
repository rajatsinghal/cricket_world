class CreateMatchPlayers < ActiveRecord::Migration
  def change
    create_table :match_players do |t|
      t.integer :match_id
      t.integer :team_id
      t.integer :player_id
      t.boolean :is_captain
      t.boolean :is_wicket_keeper

      t.timestamps
    end
  end
end
