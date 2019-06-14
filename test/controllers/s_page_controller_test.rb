require 'test_helper'

class SPageControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get s_page_home_url
    assert_response :success
  end

end
