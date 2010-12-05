require 'test_helper'

class MemberWorkoutTest < ActiveSupport::TestCase
  
  setup do
    clear
  end
  
  test "Get number of intervals" do
    w = Workout.create(:title => '2x 1000')
    mw = MemberWorkout.create(:workout => w)

    assert_equal 0, mw.intervals.count
    assert_equal mw, mw.ensure_enough_intervals
    assert_not_equal 0, mw.intervals.count
  end
end
