require 'test_helper'

class Service::SermonsControllerTest < ActionController::TestCase
  setup do
    @service_sermon = service_sermons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:service_sermons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create service_sermon" do
    assert_difference('Service::Sermon.count') do
      post :create, service_sermon: @service_sermon.attributes
    end

    assert_redirected_to service_sermon_path(assigns(:service_sermon))
  end

  test "should show service_sermon" do
    get :show, id: @service_sermon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @service_sermon
    assert_response :success
  end

  test "should update service_sermon" do
    put :update, id: @service_sermon, service_sermon: @service_sermon.attributes
    assert_redirected_to service_sermon_path(assigns(:service_sermon))
  end

  test "should destroy service_sermon" do
    assert_difference('Service::Sermon.count', -1) do
      delete :destroy, id: @service_sermon
    end

    assert_redirected_to service_sermons_path
  end
end
