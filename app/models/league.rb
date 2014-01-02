class League < ActiveRecord::Base
	has_many :league_statuses
  	accepts_nested_attributes_for :league_statuses, allow_destroy: true, :reject_if => proc { |attributes| attributes['team_id'].blank? }

  	validates_presence_of :name, :description
end
