class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.datetime :start_time
      t.string :stadium_name

      t.timestamps
    end
  end
end
