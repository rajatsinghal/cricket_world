ActiveAdmin.register LeagueStatus do
  
  menu false
  
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
