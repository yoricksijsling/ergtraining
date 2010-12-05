require 'test_helper'

class WorkoutsControllerTest < ActionController::TestCase
  setup do
    clear
    @yorick = Member.new(:name => 'Yorick')
    @henk = Member.new(:name => 'Henk')
    Team.create(:title => 'TJL', :members => [@yorick, @henk])
    
    @workout = Workout.create(:title => "2x 20'", :team => Team.first)
  end

  should "get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workouts)
  end

  should "get new" do
    get :new
    assert_response :success
  end

  should "create workout" do
    assert_difference('Workout.count') do
      post :create, :workout => Workout.new(:title => "2x 20'").attributes
    end

    assert_redirected_to workout_path(assigns(:workout))
  end

  should "show workout" do
    get :show, :id => @workout.to_param
    assert_response :success
  end

  should "get edit" do
    get :edit, :id => @workout.to_param
    assert_response :success
  end

  should "destroy workout" do
    assert_difference('Workout.count', -1) do
      delete :destroy, :id => @workout.to_param
    end

    assert_redirected_to workouts_path
  end
  
  should "have routing for get_for_member" do
    assert_routing 'workouts/abc123/get_for_member/m1', { :controller => 'workouts', :action => 'get_for_member', :workout_id => 'abc123', :member_id => 'm1' }
  end
  
  should "get member workout" do
    get :get_for_member, :workout_id => @workout.to_param, :member_id => @henk.to_param
  end

  context "A PUT to workouts" do
    setup do
      put :update, :id => @workout.to_param, :workout => {
        :title => "2x 20'",
        :team => Team.first,
        :for_member_attributes => {
          @henk.to_param => { :intervals_attributes => {
            0 => { :hravg => 1, :pace => 2 },
            1 => { :hravg => 3, :pace => 4 }
          }}
        }
      }
    end

    # should redirect_to workout_path(@workout)
    should "redirect to workout" do
      assert_redirected_to workout_path(@workout)
      # assert_redirected_to workout_path(assigns(:workout))
    end
  
    should "create a member workout" do
      mw = @workout.get_for @henk
      assert_not_nil mw
      assert_equal 3, mw.intervals[1].hravg
    end
  end
end
