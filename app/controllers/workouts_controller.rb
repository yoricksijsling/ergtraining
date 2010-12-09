class WorkoutsController < ApplicationController
  before_filter :find_team
  before_filter :find_workout, :only => [:show, :edit, :update, :destroy, :get_for_member]
  
  def index
    @workouts = @team.workouts
  end

  def show
  end

  def new
    @workout = Workout.new
  end

  def get_for_member
    member = @team.get_member BSON::ObjectId.from_string(params[:member_id])
    @member_workout = @workout.get_or_new_for member
    render :layout => false
  end

  def create
    @workout = Workout.new params[:workout]
    @workout.team = @team

    if @workout.save
      redirect_to [@team, @workout], :notice => 'Workout was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    if @workout.update_attributes(params[:workout])
      redirect_to [@team, @workout], :notice => 'Workout was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def destroy
    @workout.destroy
    redirect_to @team
  end

  
  def find_team
    @team = Team.find params[:team_id]
  end
  
  def find_workout
    @workout = Workout.find(params[:id] || params[:workout_id])
    if @workout && @workout.team != @team
      @workout = nil
    end
  end
end
