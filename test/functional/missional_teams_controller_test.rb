require 'test_helper'

class MissionalTeamsControllerTest < ActionController::TestCase
  setup do
    @missional_team = missional_teams(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:missional_teams)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create missional_team" do
    assert_difference('MissionalTeam.count') do
      post :create, missional_team: @missional_team.attributes
    end

    assert_redirected_to missional_team_path(assigns(:missional_team))
  end

  test "should show missional_team" do
    get :show, id: @missional_team
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @missional_team
    assert_response :success
  end

  test "should update missional_team" do
    put :update, id: @missional_team, missional_team: @missional_team.attributes
    assert_redirected_to missional_team_path(assigns(:missional_team))
  end

  test "should destroy missional_team" do
    assert_difference('MissionalTeam.count', -1) do
      delete :destroy, id: @missional_team
    end

    assert_redirected_to missional_teams_path
  end
end
