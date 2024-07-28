require "test_helper"

class JoinRequestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get join_requests_index_url
    assert_response :success
  end

  test "should get create" do
    get join_requests_create_url
    assert_response :success
  end

  test "should get update" do
    get join_requests_update_url
    assert_response :success
  end

  test "should get destroy" do
    get join_requests_destroy_url
    assert_response :success
  end
end
