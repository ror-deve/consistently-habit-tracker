require "test_helper"

class HabitsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get habits_index_url
    assert_response :success
  end
end
