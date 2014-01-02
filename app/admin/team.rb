ActiveAdmin.register Team do
  permit_params :name, :description
  
  collection_action :create_teams do    
  end
end
