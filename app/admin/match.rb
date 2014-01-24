ActiveAdmin.register Match do
  permit_params :home_team_id, :away_team_id, :start_time, :stadium_name
  
  
end
