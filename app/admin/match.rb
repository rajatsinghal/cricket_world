ActiveAdmin.register Match do
  permit_params :home_team_id, :away_team_id, :start_time, :stadium_name, :start_time_date, :start_time_time_hour, :start_time_time_minute
  
  form do |f|
    f.inputs "" do
      f.input :home_team
      f.input :away_team
      f.input :start_time, :as => :just_datetime_picker
      f.input :stadium_name
    end
    f.actions
  end
end
