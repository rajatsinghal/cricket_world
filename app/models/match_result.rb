class MatchResult < ActiveRecord::Base
  belongs_to :match
  
  TOSS_CHOICE_BATTING_FIRST = "BATTING_FIRST";
  TOSS_CHOICE_BOWLING_FIRST = "BOWLING_FIRST";
  
  TOSS_CHOICES = {
    "Batting First"=>TOSS_CHOICE_BATTING_FIRST,
    "Bowling First"=>TOSS_CHOICE_BOWLING_FIRST,
  }
  
  def first_batting_team_id
    if toss_choice == TOSS_CHOICE_BATTING_FIRST
      return toss_winner_team_id
    else
      return match.get_opponent_team_id(toss_winner_team_id)
    end
  end
end
