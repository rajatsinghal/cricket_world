ActiveAdmin.register User do
  
  actions :all, except: [:show]
  
  permit_params :name, :email, :phone_number, :password, :password_confirmation, :temporary_password, players_attributes: [:id, :team_id, :_destroy], team_managers_attributes: [:id, :team_id, :_destroy]
  
  form do |f|
    f.inputs "User Details" do
      f.semantic_errors *f.object.errors.keys
      f.input :name
      f.input :email
      f.input :phone_number
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
  
  index do 
    column :id    
    column :name
    column :email    
    column :phone_number 
    column 'Plays for', :players do |user|
      user.players.map {|c| c.team.name}.join(', ')
    end   
    column 'Manages', :team_managers do |user|
      user.team_managers.map {|c| c.team.name}.join(', ')
    end
    actions
  end
  
  controller do
    def create
      random_temporary_password = User.get_random_temporary_password
      params[:user].merge!({ password: random_temporary_password, password_confirmation: random_temporary_password, temporary_password: random_temporary_password })
      create!
    end
  end
  
end
