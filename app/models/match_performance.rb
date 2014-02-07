class MatchPerformance < ActiveRecord::Base
  scope :filter_team, lambda {|team_id| where("team_id = ?", team_id)}
  
  belongs_to :player
  belongs_to :match
  belongs_to :team

  before_save :update_overs

  def update_overs
  	if !balls_bowled.blank?
  		if balls_bowled.to_s.include? "."
	  		parts = balls_bowled.split('.')
	  		if parts.length > 1
	  			self.balls_bowled = (parts[0].to_i * 6) + parts[1].to_i
	  		else
	  			self.balls_bowled = balls_bowled.to_i * 6
	  		end
	  	else
	  		self.balls_bowled = balls_bowled.to_i * 6
	  	end
  	end
  end

end
