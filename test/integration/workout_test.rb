require 'test_helper'

class WorkoutTest < ActionController::IntegrationTest
  
  setup do
    clear
    create_team
    @workout = Workout.create(:title => "2x 20'", :team => @team)
  end

  should "associate team and workout" do
    assert_equal @workout, @team.workouts[0]
    assert_equal @team, @workout.team    
  end

  context "getting a new member_workout" do
    setup do
      @mw1 = @workout.get_or_new_for @team.members.first
    end
    
    should "not save the member_workout" do
      assert_nil @workout.reload.get_for(@team.members.first)
    end
    
    context "and trying to create it without data" do
      should "not create it" do
        @mw1.intervals [Interval.new(:pace => "", :hravg => "")]
        @mw1.save
        assert_nil @workout.reload.get_for(@team.members.first)
      end
    end
    
    context "and trying to update it without data" do
      should "remove it" do
        @mw1.intervals = [Interval.new(:pace => "115.5", :hravg => "165")]
        @mw1.save
        @mw1.intervals = [Interval.new(:pace => "", :hravg => "")]
        @mw1.save
        assert_nil @workout.reload.get_for(@team.members.first)
      end
    end
 
    context "and saving it" do
      setup do
        @mw1.intervals << Interval.new(:pace => "115.5", :hravg => "165")
        @mw1.intervals << Interval.new(:pace => "116.3", :hravg => "170")
        @mw1.save
        @workout.reload
      end
    
      should "increment the member_workouts count" do
        assert_equal 1, @workout.member_workouts.count
      end
    
      should "associate workout and member_workout" do
        assert_equal @mw1, @workout.get_for(@team.members.first)
        assert_equal @workout, @mw1.workout
      end
    
      should "associate workout and member" do
        assert_equal @team.members.first, @mw1.member
        assert_equal @team.members.first.member_workouts[0], @mw1
      end
    end
  end
end