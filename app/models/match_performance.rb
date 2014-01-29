class MatchPerformance < ActiveRecord::Base
  scope :filter_team, lambda {|team_id| where("team_id = ?", team_id)}
  
  belongs_to :player
  belongs_to :match
  belongs_to :team
end
