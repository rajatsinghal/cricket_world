class DescriptionInMatch < ActiveRecord::Migration
  def change
  	add_column :matches, :description, :text
  end
end
