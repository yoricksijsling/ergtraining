require 'test_helper'

class WorkoutsControllerTest < ActionController::TestCase
  setup do
    clear
    @yorick = Member.new(:name => 'Yorick')
    @henk = Member.new(:name => 'Henk')
    Team.create(:title => 'TJL', :members => [@yorick, @henk])
    
    @workout = Workout.new(:title => "2x 20'", :team => Team.first)
    @workout.save
    
    @member_workout = @workout.get_or_create_for @yorick
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workouts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workout" do
    assert_difference('Workout.count') do
      post :create, :workout => Workout.new(:title => "2x 20'").attributes
    end

    assert_redirected_to workout_path(assigns(:workout))
  end

  test "should show workout" do
    get :show, :id => @workout.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @workout.to_param
    assert_response :success
  end

  test "should update workout" do
    put :update, :id => @workout.to_param, :workout => @workout.attributes
    assert_redirected_to workout_path(assigns(:workout))
  end

  test "should destroy workout" do
    assert_difference('Workout.count', -1) do
      delete :destroy, :id => @workout.to_param
    end

    assert_redirected_to workouts_path
  end
  
  test "create member workout route" do
    assert_routing 'workouts/abc123/create_for_member/m1', { :controller => 'workouts', :action => 'create_for_member', :workout_id => 'abc123', :member_id => 'm1' }
  end
  
  test "should create member workout" do
    assert_nil @workout.get_for @henk
    get :create_for_member, :workout_id => @workout.to_param, :member_id => @henk._id
    assert_not_nil @workout.get_for @henk
  end
end
