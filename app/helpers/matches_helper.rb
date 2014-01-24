module MatchesHelper
  def get_match_title(match)
    match.home_team.name+' vs '+match.away_team.name
  end
end