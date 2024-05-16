require "test_helper"

class ChatHistoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get chat_histories_index_url
    assert_response :success
  end
end
