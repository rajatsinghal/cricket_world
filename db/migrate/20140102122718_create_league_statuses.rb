class CreateLeagueStatuses < ActiveRecord::Migration
  def change
    create_table :league_statuses do |t|
      t.integer :league_id
      t.integer :team_id
      t.integer :matches_played, :default => 0
      t.integer :position, :default => 0
      t.integer :wins, :default => 0
      t.integer :losses, :default => 0
      t.integer :ties, :default => 0
      t.integer :points, :default => 0
      t.decimal :run_rate, :precision => 10, :scale => 2

      t.timestamps
    end
  end
end
