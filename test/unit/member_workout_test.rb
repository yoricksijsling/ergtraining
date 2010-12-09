require 'test_helper'

class MemberWorkoutTest < ActiveSupport::TestCase
  
  setup do
    clear
    create_team
    @workout = Workout.create(:title => '2x 1000')
    @mw1 = @workout.get_or_new_for @team.members.first
  end
  
  should "have no intervals by default" do
    assert_equal 0, @mw1.intervals.count
  end
  
  context "contains_data" do
    should "return false by default" do
      assert !@mw1.contains_data
    end
    
    should "return false when an empty interval is added" do
      @mw1.intervals << Interval.new()
      assert !@mw1.contains_data
    end
    
    should "return true when an interval with data is added" do
      @mw1.intervals << Interval.new(:hravg => "123")
      assert @mw1.contains_data
    end
  end
  
  context "ensuring enough intervals" do
    setup do
      assert_equal @mw1, @mw1.ensure_enough_intervals
    end
    
    should "increase number of intervals" do
      assert_not_equal 0, @mw1.intervals.count
    end
  end
end
