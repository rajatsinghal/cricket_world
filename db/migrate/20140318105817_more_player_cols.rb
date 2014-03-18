class MorePlayerCols < ActiveRecord::Migration
  def change
  	add_column :users, :age, :string
  	add_column :users, :height, :string
  	add_column :users, :batting_style, :string
  	add_column :users, :bowling_style, :string
  end
end