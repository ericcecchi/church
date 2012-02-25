require 'test_helper'

class CommunityGroupsControllerTest < ActionController::TestCase
  setup do
    @community_group = community_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:community_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create community_group" do
    assert_difference('CommunityGroup.count') do
      post :create, community_group: @community_group.attributes
    end

    assert_redirected_to community_group_path(assigns(:community_group))
  end

  test "should show community_group" do
    get :show, id: @community_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @community_group
    assert_response :success
  end

  test "should update community_group" do
    put :update, id: @community_group, community_group: @community_group.attributes
    assert_redirected_to community_group_path(assigns(:community_group))
  end

  test "should destroy community_group" do
    assert_difference('CommunityGroup.count', -1) do
      delete :destroy, id: @community_group
    end

    assert_redirected_to community_groups_path
  end
end
