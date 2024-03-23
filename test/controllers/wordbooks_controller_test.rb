require "test_helper"

class WordbooksControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get wordbooks_new_url
    assert_response :success
  end

  test "should get create" do
    get wordbooks_create_url
    assert_response :success
  end

  test "should get edit" do
    get wordbooks_edit_url
    assert_response :success
  end

  test "should get update" do
    get wordbooks_update_url
    assert_response :success
  end

  test "should get show" do
    get wordbooks_show_url
    assert_response :success
  end
end
