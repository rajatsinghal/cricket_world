class CreateMatchInnings < ActiveRecord::Migration
  def change
    create_table :match_innings do |t|
      t.integer :match_id
      t.integer :number
      t.integer :wides
      t.integer :no_balls
      t.integer :byes
      t.integer :leg_byes

      t.timestamps
    end
  end
end
