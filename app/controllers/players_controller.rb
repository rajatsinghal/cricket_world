class PlayersController < ApplicationController  
  def show
    @team = Team.find(params[:id])
  end
end