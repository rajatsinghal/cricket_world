class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  
  validates_presence_of :team_id
  
  scope :filter_team, lambda {|team_id| where("team_id = ?", team_id)}
  
  def name
    return user.name
  end
end
