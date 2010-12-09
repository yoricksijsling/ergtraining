require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  setup do
    clear
  end
  
  should "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams)
  end
  
  context "with team" do
    setup do
      create_team
    end
    
    should "get show" do
      get :show, :id => @team.to_param
      assert_response :success
      assert_equal @team.workouts, assigns(:workouts)
      assert_equal @team.members, assigns(:members)
    end
  end
end

