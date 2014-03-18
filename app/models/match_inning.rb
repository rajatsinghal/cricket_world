class MatchInning < ActiveRecord::Base
  belongs_to :match
  
  scope :filter_team, lambda {|team_id| where("team_id = ?", team_id)}
  
  def overs
    if balls.nil?
      return nil
    else
      return (balls/6).to_s+"."+(balls%6).to_s+" ov";
    end
  end

  def self.return_overs(balls)
    if !balls.blank?
  	 return (balls/6).to_s+"."+(balls%6).to_s+" ov";
    else
      return nil
    end
  end

  def self.return_overs_without_string(balls)
    if !balls.blank?
      if balls%6 == 0
        return (balls/6).to_s
      else
        return (balls/6).to_s+"."+(balls%6).to_s;
      end
    else
      return nil
    end
  end
end
