class Create < ActiveRecord::Migration
  def change
    add_column :match_innings, :runs, :integer, :after=>:leg_byes
    add_column :match_innings, :balls, :integer, :after=>:runs
    add_column :match_innings, :wickets, :integer, :after=>:balls
  end
end
