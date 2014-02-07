ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, teams_attributes: [:id, :name, :_destroy]

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
        format.html { redirect_to admin_teams_path, :notice => "Teams added successfully" }
      end
    end
  end

end
