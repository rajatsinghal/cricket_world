class Match < ActiveRecord::Base
  
  STATUS_INITIALIZED = 1;
  STATUS_SCORED_ENTERED = 2;
  
  belongs_to :home_team, :class_name=>'Team', :foreign_key=>'home_team_id'
  belongs_to :away_team, :class_name=>'Team', :foreign_key=>'away_team_id'
  has_one :match_result
  has_many :match_innings
  has_many :team_a_match_players
  has_many :team_b_match_players
  has_one :first_match_inning
  has_one :second_match_inning
  
  validates_presence_of :home_team_id, :away_team_id
  accepts_nested_attributes_for :match_result, :team_a_match_players, :team_b_match_players, :first_match_inning, :second_match_inning
  before_save :default_status
  
  def default_status
    self.status = STATUS_INITIALIZED
  end
  
  def first_batting_team
    if !match_result
      return NULL
    else
      return Team.find(match_result.first_batting_team_id)
    end
  end
  
  def get_opponent_team_id(team_id)
    if(home_team_id == team_id)
      return away_team_id
    else
      return home_team_id 
    end
  end
  
  scope :initialized, lambda { where(:status => STATUS_INITIALIZED) }
end
