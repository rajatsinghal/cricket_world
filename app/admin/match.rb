ActiveAdmin.register Match do
  
  actions :all, except: [:show]
  
  permit_params :home_team_id, :away_team_id, :start_time, :stadium_name, :start_time_date, :start_time_time_hour, :start_time_time_minute, :description
  
  form do |f|
    f.inputs "" do
      f.input :home_team
      f.input :away_team
      f.input :start_time, :as => :just_datetime_picker
      f.input :stadium_name
      f.input :description
    end
    f.actions
  end
  
  index do
    column :id
    column 'Team A', :home_team
    column 'Team B', :away_team
    column :start_time
    column :stadium_name
    column :description
    #column :status do |match|
    #  Match::STATUSES[match.status]
    #end
    actions do |match|
      link_to "Update Scores", upload_lineup_match_path(match), target: "_blank"
    end
  end
end
