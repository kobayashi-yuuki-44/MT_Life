require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get pages_new_url
    assert_response :success
  end

  test "should get create" do
    get pages_create_url
    assert_response :success
  end

  test "should get show" do
    get pages_show_url
    assert_response :success
  end

  test "should get edit" do
    get pages_edit_url
    assert_response :success
  end

  test "should get update" do
    get pages_update_url
    assert_response :success
  end
end
