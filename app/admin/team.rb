ActiveAdmin.register Team do
  permit_params :name, :description
  action_item(:only => :index) do
    link_to("Create Teams", create_teams_admin_teams_path)
  end
  collection_action :create_teams do    
  end
  
  index do
    column :id
    column :name
    column :description
    actions
  end
  
end
