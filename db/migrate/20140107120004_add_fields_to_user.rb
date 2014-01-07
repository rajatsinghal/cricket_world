class AddFieldsToUser < ActiveRecord::Migration
  def change
    add_column :users, :name, :string, :after=>:id
    add_column :users, :phone_number, :string, :after=>:email
  end
end
