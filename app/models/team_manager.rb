class TeamManager < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  
  validates_presence_of :team_id
end
