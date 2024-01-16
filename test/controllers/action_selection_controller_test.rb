require "test_helper"

class ActionSelectionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get action_selection_index_url
    assert_response :success
  end
end
