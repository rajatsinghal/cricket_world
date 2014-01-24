class AddTeamIdToInning < ActiveRecord::Migration
  def change
    add_column :match_innings, :team_id, :integer, :after=>:match_id
  end
end