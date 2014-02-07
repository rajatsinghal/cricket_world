class LeagueStatus < ActiveRecord::Base
	belongs_to :league
	belongs_to :team

	validates_uniqueness_of :team_id, :scope => :league_id

	def display_name
  		self.league.name + '-' + self.team.name
  	end
end
