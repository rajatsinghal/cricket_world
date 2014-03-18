class MatchesController < ApplicationController
  
  #permit_params match_player_attributes: [:player_id, :_destroy]
  
  def index
    @matches = Match.initialized.all
  end
  
  def show
    @match = Match.find(params[:id])
  end
  
  def upload_lineup
    @match = Match.find(params[:id])
    if @match.team_a_match_players.length < Match::PLAYERS
      Match::PLAYERS.times { @match.team_a_match_players.build }
    end
    if @match.team_b_match_players.length < Match::PLAYERS
      Match::PLAYERS.times { @match.team_b_match_players.build }
    end
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
    redirect_to upload_inning_match_path(match, {:number=>1})
  end
  
  def upload_inning
    @match = Match.find(params[:id])
    @match.create_innings
    if params[:number].to_i == 1
      @innings = @match.match_innings.where("number = #{params[:number]}").first
      @team = @match.first_batting_team
      @bowling_team = @match.second_batting_team
      @batting_performances = @match.first_batting_performances
      @bowling_performances = @match.second_batting_performances
      @batting_players = @match.first_batting_players
      @bowling_players = @match.second_batting_players
      @url = save_inning_match_path(@match, {:number =>2})
    else
      @innings = @match.match_innings.where("number = #{params[:number]}").first
      @team = @match.second_batting_team
      @bowling_team = @match.first_batting_team
      @batting_performances = @match.second_batting_performances
      @bowling_performances = @match.first_batting_performances
      @batting_players = @match.second_batting_players
      @bowling_players = @match.first_batting_players
      @url = save_inning_match_path(@match)
    end

  end
  
  def save_inning
    match = Match.find(params[:id])
    match.attributes = match_params
    match.save
    #match.update_innings_data
    flash[:success] = "Innings data saved!"
    if params.has_key?("number")
      redirect_to upload_inning_match_path(match, {:number=>2})
    else
      redirect_to match_path(match)
      #redirect_to upload_inning_match_path(match, {:number=>2})
    end
  end
  
  private
  
  def match_params
    params.require(:match).permit(
      :home_team_id, :away_team_id, 
      team_a_match_players_attributes:[:player_id, :team_id], 
      team_b_match_players_attributes:[:player_id, :team_id], 
      match_result_attributes:[:toss_winner_team_id, :toss_choice],
      match_performances_attributes:[:id, :player_id, :team_id, :batting_position, :runs_scored, :balls_faced, :fours, :sixes, :mode_of_dismissal, :bowling_position, :balls_bowled, :runs_conceded, :wickets]
    )
  end
end