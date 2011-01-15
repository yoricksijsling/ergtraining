require 'test_helper'

class WorkoutsControllerTest < ActionController::TestCase
  setup do
    clear
    
    @yorick = Member.new(:name => 'Yorick')
    @henk = Member.new(:name => 'Henk')
    @team = Team.create(:title => 'TJL', :members => [@yorick, @henk])
    
    @workout = Workout.create(:title => "2x 20'", :team => @team)
  end

  should "get new" do
    get :new, :team_id => @team.to_param
    assert_response :success
  end

  should "create workout" do
    new_workout = Workout.new(:title => "2x 20'", :date => Date.new(2010, 5, 18))
    assert_difference('Workout.count') do
      post :create, :workout => new_workout.attributes, :team_id => @team.to_param
    end
    
    assert_equal Date.new(2010, 5, 18), assigns(:workout).date
    assert_redirected_to team_workout_path(@team, assigns(:workout))
  end

  should "show workout" do
    get :show, :id => @workout.to_param, :team_id => @team.to_param
    assert_response :success
  end

  should "destroy workout" do
    assert_difference('Workout.count', -1) do
      delete :destroy, :id => @workout.to_param, :team_id => @team.to_param
    end

    assert_redirected_to @team
  end
  
  should "have routing for get_for_member" do
    assert_routing 'teams/myteam/workouts/myworkout/get_for_member/m1', { :controller => 'workouts', :action => 'get_for_member', :workout_id => 'myworkout', :member_id => 'm1', :team_id => 'myteam' }
  end
  
  context "getting a new member workout" do
    setup do
      post :get_for_member, :workout_id => @workout.to_param, :member_id => @henk.to_param, :team_id => @team.to_param
    end
    
    should "not save the member workout" do
      assert_nil @workout.reload.get_for(@henk)
    end
  end
  
  context "A PUT to workouts" do
    setup do
      put :update, :id => @workout.to_param, :team_id => @team.to_param, :workout => {
        :for_member_attributes => {
          @henk.to_param => {
            :comment => 'mycomment',
            :intervals_attributes => {
              0 => { :hravg => 1, :pace => "1:50.2" },
              1 => { :hravg => 3, :pace => "1:51.3" }
            }
          }
        }
      }
    end

    # should redirect_to workout_path(@workout)
    should "redirect to workout" do
      assert_redirected_to team_workout_path(@team, @workout)
    end
  
    should "create a member workout" do
      mw = @workout.get_for @henk
      assert_not_nil mw
      assert_equal 3, mw.intervals[1].hravg
      assert_equal 'mycomment', mw.comment
    end
  end
end
