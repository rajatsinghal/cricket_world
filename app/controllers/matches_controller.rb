class MatchesController < ApplicationController
  def index
    @matches = Match.initialized.all
  end
  
  def upload_lineup
    @match = Match.find(params[:id])
    #11.times(@match.match_players.build
  end
end