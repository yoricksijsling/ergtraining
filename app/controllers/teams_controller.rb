class TeamsController < ApplicationController
  before_filter :find_team, :only => [:show, :edit, :update]
  
  def index
    @teams = Team.all
  end

  def show
    render :layout => "in_team"
  end

  def new
    @workout = Workout.new
  end
  
  def create
    @team = Team.new(params[:team])
    if @team.save
      redirect_to(@team, :notice => 'Team was successfully created.')
    else
      render :action => "new"
    end
  end
  
  def edit
  end

  def update
    if @team.update_attributes(params[:team])
      redirect_to(@team, :notice => 'Team was successfully updated.')
    else
      render :action => "edit"
    end
  end

  # DELETE /teams/1
  # def destroy
  #   @team.destroy
  #   redirect_to(teams_url)
  # end
  
  def find_team
    @team = Team.find(params[:id]) if params[:id]
  end
end
