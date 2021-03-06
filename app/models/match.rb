class Match < ActiveRecord::Base
  
  STATUS_INITIALIZED = 1;
  STATUS_SCORED_ENTERED = 2;
  STATUSES = { self::STATUS_INITIALIZED => 'Pending',  self::STATUS_SCORED_ENTERED => 'Score Updated' }
  
  belongs_to :home_team, :class_name=>'Team', :foreign_key=>'home_team_id'
  belongs_to :away_team, :class_name=>'Team', :foreign_key=>'away_team_id'
  has_one :match_result, :dependent => :delete
  has_many :match_innings, :dependent => :delete_all
  has_many :match_players, :dependent => :delete_all
  has_many :match_performances, :dependent => :delete_all
  
  #sti
  has_many :team_a_match_players
  has_many :team_b_match_players
  has_one :first_match_inning
  has_one :second_match_inning
    
  validates_presence_of :home_team_id, :away_team_id
  accepts_nested_attributes_for :match_result, :team_a_match_players, :team_b_match_players, :first_match_inning, :second_match_inning, :match_performances
  before_save :default_status
  just_define_datetime_picker :start_time

  #after_save :update_innings_data

  PLAYERS = 7
  
  def default_status
    self.status = STATUS_INITIALIZED
  end
  
  def create_innings
    if(!self.first_match_inning)
      self.build_first_match_inning({:team_id=>match_result.first_batting_team_id, :number=>1})
      self.first_match_inning.save
      first_batting_players.each_with_index do |match_player, index|
        self.match_performances.create({:team_id=>match_result.first_batting_team_id, :batting_position=>(index+1), :bowling_position=>(index+1)})
      end
    end
    if(!self.second_match_inning)
      self.build_second_match_inning({:team_id=>match_result.second_batting_team_id, :number=>2})
      self.second_match_inning.save
      second_batting_players.each_with_index do |match_player, index|
        self.match_performances.create({:team_id=>match_result.second_batting_team_id, :batting_position=>(index+1), :bowling_position=>(index+1)})
      end
    end
  end
  
  def first_batting_team
    if !match_result
      return NULL
    else
      return Team.find(match_result.first_batting_team_id)
    end
  end

  def second_batting_team
    if !match_result
      return NULL
    else
      return Team.find(match_result.second_batting_team_id)
    end
  end
  
  def first_batting_performances
    if(match_result.first_batting_team_id)
      return self.match_performances.filter_team(match_result.first_batting_team_id)
    else
      return NULL
    end
  end
  
  def second_batting_performances
    if(match_result.second_batting_team_id)
      return self.match_performances.filter_team(match_result.second_batting_team_id)
    else
      return NULL
    end
  end
  
  def first_batting_players
    if(match_result.first_batting_team_id)
      return self.match_players.filter_team(match_result.first_batting_team_id)
    else
      return NULL
    end
  end
  
  def second_batting_players
    if(match_result.first_batting_team_id)
      return self.match_players.filter_team(match_result.second_batting_team_id)
    else
      return NULL
    end
  end
  
  def home_team_inning
    match_innings.filter_team(home_team_id).first
  end
  
  def away_team_inning
    match_innings.filter_team(away_team_id).first
  end
  
  def get_opponent_team_id(team_id)
    if(home_team_id == team_id)
      return away_team_id
    else
      return home_team_id 
    end
  end
  
  def get_title
    if home_team_inning && away_team_inning
		  #return "#{home_team.name} <span class='result_score'>#{home_team_inning.runs}/#{home_team_inning.wickets} <span>#{home_team_inning.overs}</span></span> v #{away_team.name} <span class='result_score'>#{away_team_inning.runs}/#{away_team_inning.wickets} <span>#{away_team_inning.overs}</span></span>"
      return "#{home_team.name} v #{away_team.name}"
		else
		  return "#{home_team.name} v #{away_team.name}"
		end
  end

  def update_innings_data
    if !away_team_inning.blank? and !home_team_inning.blank? and !match_performances.blank?
      if home_team_id == match_result.second_batting_team_id
        self.home_team_inning.runs = first_batting_performances.map{|m| m.runs_scored.to_i}.inject(&:+)
        self.home_team_inning.wickets = first_batting_performances.where("mode_of_dismissal is not null and mode_of_dismissal != ''").length
        self.home_team_inning.balls = first_batting_performances.map{|m| m.balls_faced.to_i}.inject(&:+)

        self.away_team_inning.runs = second_batting_performances.map{|m| m.runs_scored.to_i}.inject(&:+)
        self.away_team_inning.wickets = second_batting_performances.where("mode_of_dismissal is not null and mode_of_dismissal != ''").length
        self.away_team_inning.balls = second_batting_performances.map{|m| m.balls_faced.to_i}.inject(&:+)
      else
        self.away_team_inning.runs = first_batting_performances.map{|m| m.runs_scored.to_i}.inject(&:+)
        self.away_team_inning.wickets = first_batting_performances.where("mode_of_dismissal is not null and mode_of_dismissal != ''").length
        self.away_team_inning.balls = first_batting_performances.map{|m| m.balls_faced.to_i}.inject(&:+)

        self.home_team_inning.runs = second_batting_performances.map{|m| m.runs_scored.to_i}.inject(&:+)
        self.home_team_inning.wickets = second_batting_performances.where("mode_of_dismissal is not null and mode_of_dismissal != ''").length
        self.home_team_inning.balls = second_batting_performances.map{|m| m.balls_faced.to_i}.inject(&:+)
      end
      self.home_team_inning.save
      self.away_team_inning.save
    end
  end

  def scores
    home_team_runs = home_team_wickets = home_team_balls = away_team_runs = away_team_wickets = away_team_balls = 0
    if !away_team_inning.blank? and !home_team_inning.blank? and !match_performances.blank?
      if home_team_id == match_result.second_batting_team_id
        home_team_runs = first_batting_performances.map{|m| m.runs_scored.to_i}.inject(&:+)
        home_team_wickets = first_batting_performances.where("mode_of_dismissal is not null and mode_of_dismissal != ''").length
        home_team_balls = first_batting_performances.map{|m| m.balls_faced.to_i}.inject(&:+)

        away_team_runs = second_batting_performances.map{|m| m.runs_scored.to_i}.inject(&:+)
        away_team_wickets = second_batting_performances.where("mode_of_dismissal is not null and mode_of_dismissal != ''").length
        away_team_balls = second_batting_performances.map{|m| m.balls_faced.to_i}.inject(&:+)
      else
        home_team_runs = first_batting_performances.map{|m| m.runs_scored.to_i}.inject(&:+)
        home_team_wickets = first_batting_performances.where("mode_of_dismissal is not null and mode_of_dismissal != ''").length
        home_team_balls = first_batting_performances.map{|m| m.balls_faced.to_i}.inject(&:+)

        away_team_runs = second_batting_performances.map{|m| m.runs_scored.to_i}.inject(&:+)
        away_team_wickets = second_batting_performances.where("mode_of_dismissal is not null and mode_of_dismissal != ''").length
        away_team_balls = second_batting_performances.map{|m| m.balls_faced.to_i}.inject(&:+)
      end
    end
    return [home_team_runs , home_team_wickets , home_team_balls , away_team_runs , away_team_wickets , away_team_balls]
  end
  
  scope :initialized, lambda { where(:status => STATUS_INITIALIZED) }
  scope :played_by_team, lambda { |team_id| where("home_team_id = #{team_id} or away_team_id = #{team_id}") }
end
