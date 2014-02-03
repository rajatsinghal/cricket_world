class Team < ActiveRecord::Base  
  belongs_to :admin_user
  has_many :league_statuses, :dependent => :delete_all
  has_many :players, :dependent => :delete_all
  
  def latest_league_status
    return self.league_statuses.last
  end
  
  def top_run_scorer
    players.first
  end
  
  def top_wicket_taker
    players.last
  end
  
  def captain
    players.first
  end
  
  def recent_matches
    Match.played_by_team(id).limit(5)
  end
end