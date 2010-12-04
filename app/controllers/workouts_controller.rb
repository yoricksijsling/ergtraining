class WorkoutsController < ApplicationController
  before_filter :find_team
  before_filter :find_workout, :only => [:show, :edit, :update, :destroy, :create_for_member]
  
  # GET /workouts
  # GET /workouts.xml
  def index
    @workouts = @team.workouts

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @workouts }
    end
  end

  # GET /workouts/1
  # GET /workouts/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @workout }
    end
  end

  # GET /workouts/new
  # GET /workouts/new.xml
  def new
    @workout = Workout.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @workout }
    end
  end

  # GET /workouts/1/edit
  def edit
  end
  
  def create_for_member
    @member = @team.members.select{ |m| m._id == params[:member_id] }.first
    @member_workout = @workout.get_or_create_for @member
    render :json => @member_workout
  end

  # POST /workouts
  # POST /workouts.xml
  def create
    @workout = Workout.new(params[:workout])
    @workout.team = @team

    respond_to do |format|
      if @workout.save
        format.html { redirect_to(@workout, :notice => 'Workout was successfully created.') }
        format.xml  { render :xml => @workout, :status => :created, :location => @workout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @workout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /workouts/1
  # PUT /workouts/1.xml
  def update
    respond_to do |format|
      if @workout.update_attributes(params[:workout])
        format.html { redirect_to(@workout, :notice => 'Workout was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @workout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /workouts/1
  # DELETE /workouts/1.xml
  def destroy
    @workout.destroy

    respond_to do |format|
      format.html { redirect_to(workouts_url) }
      format.xml  { head :ok }
    end
  end
  
  def find_team
    @team = Team.first # Wow
  end
  
  def find_workout
    @workout = Workout.find(params[:id] || params[:workout_id])
    if @workout && @workout.team != @team
      @workout = nil
    end
  end
end
