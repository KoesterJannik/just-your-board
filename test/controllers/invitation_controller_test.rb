require "test_helper"

class InvitationControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get invitation_new_url
    assert_response :success
  end

  test "should get create" do
    get invitation_create_url
    assert_response :success
  end

  test "should get accept" do
    get invitation_accept_url
    assert_response :success
  end
end
