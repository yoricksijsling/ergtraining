require 'test_helper'

class WorkoutTest < ActiveSupport::TestCase
  
  setup do
    clear
  end
  
  should "get the right number of intervals" do
    workout = Workout.new(:title => "2x 20'")
    assert_equal 2, workout.number_of_intervals
    assert_equal 2, workout.number_of_intervals_per_repeat
    assert_equal 1, workout.number_of_repeats
    
    workout = Workout.new(:title => "3x6x(1'/1')")
    assert_equal 18, workout.number_of_intervals
    assert_equal 6, workout.number_of_intervals_per_repeat
    assert_equal 3, workout.number_of_repeats
    
    workout = Workout.new(:title => "NKIR")
    assert_equal 1, workout.number_of_intervals
    assert_equal 1, workout.number_of_intervals_per_repeat
    assert_equal 1, workout.number_of_repeats

    assert_equal Date.today, workout.date
  end
end
