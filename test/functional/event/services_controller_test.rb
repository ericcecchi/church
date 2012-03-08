require 'test_helper'

class Event::ServicesControllerTest < ActionController::TestCase
  setup do
    @event_service = event_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:event_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create event_service" do
    assert_difference('Event::Service.count') do
      post :create, event_service: @event_service.attributes
    end

    assert_redirected_to event_service_path(assigns(:event_service))
  end

  test "should show event_service" do
    get :show, id: @event_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @event_service
    assert_response :success
  end

  test "should update event_service" do
    put :update, id: @event_service, event_service: @event_service.attributes
    assert_redirected_to event_service_path(assigns(:event_service))
  end

  test "should destroy event_service" do
    assert_difference('Event::Service.count', -1) do
      delete :destroy, id: @event_service
    end

    assert_redirected_to event_services_path
  end
end
