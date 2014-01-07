ActiveAdmin.register User do
  
  permit_params :name, :email, :password, :password_confirmation, :phone_number, players_attributes: [:id, :team_id, :_destroy], team_managers_attributes: [:id, :team_id, :_destroy]
  
  form do |f|
    f.inputs "User Details" do
      f.semantic_errors *f.object.errors.keys
      f.input :name
      f.input :email
      f.input :phone_number
      f.input :password
      f.input :password_confirmation
      f.inputs "Plays For" do
        f.has_many :players, :allow_destroy => true do |p|
          p.input :team, :collection => Team.all.map {|team| [team.name, team.id]}
        end
      end
      
      f.inputs "Manages" do
        f.has_many :team_managers, :allow_destroy => true do |p|
          p.input :team, :collection => Team.all.map {|team| [team.name, team.id]}
        end
      end
    end
    f.actions
  end
  
  show do |user|
    attributes_table do
      row :id
      row :name
      row :email
      row :phone_number
      row :players do 
        user.players.map {|c| c.team.name}.join(', ')
      end
      row :team_managers do 
        user.team_managers.map {|c| c.team.name}.join(', ')
      end
    end
  end
  
  index do 
    column :id    
    column :name
    column :email    
    column :phone_number 
    column :players do |user|
      user.players.map {|c| c.team.name}.join(', ')
    end   
    column :team_managers do |user|
      user.team_managers.map {|c| c.team.name}.join(', ')
    end
    actions
  end
  
end
