class AddColumnTypeToMatchPlayer < ActiveRecord::Migration
  def change
    add_column :match_players, :type, :string
  end
end
