class MatchesController < ApplicationController
  
  #permit_params match_player_attributes: [:player_id, :_destroy]
  
  def index
    @matches = Match.initialized.all
  end
  
  def upload_lineup
    @match = Match.find(params[:id])
    11.times { @match.team_a_match_players.build }
    11.times { @match.team_b_match_players.build }
  end
  
  def save_lineup    
    match = Match.find(params[:id])
    match.update_attributes(match_params)
    match.save
    redirect_to upload_toss_match_path(match)
  end
  
  def upload_toss
    @match = Match.find(params[:id])
    @match.build_match_result
  end
  
  def save_toss
    match = Match.find(params[:id])
    match.update_attributes(match_params)
    match.save
    redirect_to upload_inning_match_path(match)
  end
  
  def upload_inning
    @match = Match.find(params[:id])
    @match.create_innings    
  end
  
  def save_inning
    match = Match.find(params[:id])
    match.update_attributes(match_params)
    match.save
  end
  
  private
  
  def match_params
    params.require(:match).permit(
      :home_team_id, :away_team_id, 
      team_a_match_players_attributes:[:player_id, :team_id], 
      team_b_match_players_attributes:[:player_id, :team_id], 
      match_result_attributes:[:toss_winner_team_id, :toss_choice],
      match_performances_attributes:[:player_id, :batting_position, :runs_scored, :balls_faced, :fours, :sixes, :mode_of_dismissal, :bowling_position, :balls_bowled, :runs_conceded, :wickets]
    )
  end
end