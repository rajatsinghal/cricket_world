class AddColumAdminUserIdToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :admin_user_id, :integer
  end
end
