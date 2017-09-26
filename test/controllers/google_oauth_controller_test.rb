require 'test_helper'

class GoogleOauthControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get google_oauth_create_url
    assert_response :success
  end

end
