require 'test_helper'

class InternalControllerTest < ActionController::TestCase
  test "should get rails" do
    get :rails
    assert_response :success
  end

end
