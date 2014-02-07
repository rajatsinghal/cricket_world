ActiveAdmin.register LeagueStatus, :as => "League Position" do
  
  menu false
  actions :all, except: [:show, :new]
  config.sort_order = "points_desc"
  
  permit_params :league_id, :team_id, :matches_played, :position, :wins, :losses, :ties, :points, :run_rate
  
  index do 
      column :id 
      column :league_id do |league_status|
        league_status.league.name
      end  
      column :team_id do |league_status|
        league_status.team.name
      end
      column :matches_played
      column :position
      column :wins
      column :losses
      column :ties
      column :points
      column :run_rate do |league_status|
        league_status.run_rate.blank? ? 0.00 : league_status.run_rate
      end
      actions
  end
  
  form do |f|
    f.inputs do
      f.input :league, :input_html => { :disabled => true } 
      f.input :team, :input_html => { :disabled => true } 
      f.input :matches_played, :as=>:select, :collection => 0..30
      f.input :position, :as=>:select, :collection => 0..30
      f.input :wins, :as=>:select, :collection => 0..30
      f.input :losses, :as=>:select, :collection => 0..30
      f.input :ties, :as=>:select, :collection => 0..30
      f.input :points, :as=>:select, :collection => 0..30
      f.input :run_rate, :as=>:string, :placeholder =>"1.36"
    end
    f.actions
  end
  
end
