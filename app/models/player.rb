class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  
  scope :filter_team, lambda {|team_id| where("team_id = ?", team_id)}
  
  def name
    return user.name
  end
end
