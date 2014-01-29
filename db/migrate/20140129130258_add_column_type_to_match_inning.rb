class AddColumnTypeToMatchInning < ActiveRecord::Migration
  def change
    add_column :match_innings, :type, :string
  end
end
