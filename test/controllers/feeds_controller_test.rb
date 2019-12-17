require 'test_helper'

class FeedsControllerTest < ActionDispatch::IntegrationTest
  test "should get image:text" do
    get feeds_image:text_url
    assert_response :success
  end

end
