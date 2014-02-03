class MatchPlayer < ActiveRecord::Base
  belongs_to :match
  belongs_to :team
  belongs_to :player
  
  validates_uniqueness_of :player_id, :scope=>:match_id
  
  scope :filter_team, lambda {|team_id| where("team_id = ?", team_id)}
  
  def player_name
    return player.name
  end
end
