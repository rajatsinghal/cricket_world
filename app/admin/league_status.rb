ActiveAdmin.register LeagueStatus, :as => "League Position" do
  
  menu false
  
  permit_params :league_id, :team_id, :matches_played, :position, :wins, :losses, :ties, :points, :run_rate
  
  index do 
      column :id 
      column :league_id do |order|
        order.league.name
      end  
      column :team_id do |order|
        order.team.name
      end
      column :matches_played
      column :position
      column :wins
      column :losses
      column :ties
      column :points
      column :run_rate
      actions
  end
end
