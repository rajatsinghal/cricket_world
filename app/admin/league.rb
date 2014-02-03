ActiveAdmin.register League do

  permit_params :name, :description, league_statuses_attributes: [:id, :team_id, :_destroy]

  form do |f|
    f.inputs "League Details" do
      f.input :name
      f.input :description
      f.inputs "Teams" do
        f.has_many :league_statuses, :allow_destroy => true do |p|
          p.input :team, :collection => Team.all.map {|team| [team.name, team.id]}
        end
      end
    end
    f.actions
  end
  
  index do
    column :name
    column :description
    actions do |league|
      link_to "Update Positions", :controller => "league_statuses", :action => "index", 'q[league_id_eq]' => "#{league.id}".html_safe
    end
  end
  
end
