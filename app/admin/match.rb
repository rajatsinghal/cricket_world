ActiveAdmin.register Match do
  permit_params :home_team_id, :away_team_id, :start_time, :stadium_name
  
  form do |f|
    f.inputs "" do
      f.input :home_team
      f.input :away_team
      f.input :start_time
      f.input :stadium_name
    end
    f.actions
  end
end
