ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, teams_attributes: [:id, :name, :_destroy], users_attributes: [:id, :name, :email, :_destroy, :password, :password_confirmation, players_attributes: [:id, :team_id, :_destroy]]

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do
    def update
      update! do |format|
        if params[:admin_user].has_key?(:teams_attributes)
          format.html { redirect_to admin_teams_path, :notice => "Teams added successfully" }
        else
          format.html { redirect_to admin_players_path, :notice => "Players added successfully" }
        end
      end
    end
  end

end
