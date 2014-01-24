class Match < ActiveRecord::Base
  
  STATUS_INITIALIZED = 1;
  STATUS_SCORED_ENTERED = 2;
  
  belongs_to :home_team, :class_name=>'Team', :foreign_key=>'home_team_id'
  belongs_to :away_team, :class_name=>'Team', :foreign_key=>'away_team_id'
  has_one :match_result
  has_many :match_innings
  
  validates_presence_of :home_team_id, :away_team_id
  
  before_save :default_status
  
  def default_status
    self.status = STATUS_INITIALIZED
  end
end
