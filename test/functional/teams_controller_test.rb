require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  setup do
    clear
    create_team
  end
  
  should "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams)
  end
  
  should "get show" do
    get :show, :id => @team.to_param
    assert_response :success
  end
end

