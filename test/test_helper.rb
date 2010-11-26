ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
  
  def clear
    Workout.collection.remove
    Team.collection.remove
    MemberWorkout.collection.remove
  end
  
  def create_team
    @team = Team.new(:title => "TJL")
    @team.members << Member.new(:name => "Joost")
    @team.members << Member.new(:name => "Max")
    @team.members << Member.new(:name => "Niels")
    @team.members << Member.new(:name => "Yorick")
    @team.save
  end
end
