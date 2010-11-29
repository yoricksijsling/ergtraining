require 'test_helper'

class WorkoutTest < ActionController::IntegrationTest
  
  def setup
    clear
    create_team
  end
  
  test "Create workout and stuff" do
    w1 = Workout.create(:title => "2x 20'")
    @team.workouts << w1
    assert_equal w1, @team.workouts[0]
    assert_equal @team, w1.team
    
    mw1 = MemberWorkout.new()
    @team.members[0].member_workouts << mw1
    w1.member_workouts << mw1
    mw1.intervals << Interval.new(:pace => "115.5", :hravg => "165")
    mw1.intervals << Interval.new(:pace => "116.3", :hravg => "170")
    mw1.save
    
    mw2 = MemberWorkout.new()
    @team.members[1].member_workouts << mw2
    w1.member_workouts << mw2
    mw2.intervals << Interval.new(:pace => "118.5", :hravg => "172")
    mw2.intervals << Interval.new(:pace => "118.3", :hravg => "172")
    mw2.save
    
    assert_equal w1, mw1.workout
    assert_equal @team.members[0], mw1.member
    assert_equal @team.members[0].member_workouts[0], mw1
    
  end

end