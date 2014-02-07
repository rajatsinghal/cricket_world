class TeamsController < ApplicationController  
  def show
    @team = Team.find(params[:id])
  end

  def players
    @team = Team.find(params[:id])
  end

  def matches
    @team = Team.find(params[:id])
  end

  def forum
  end
  
  def public_forum
  end

end