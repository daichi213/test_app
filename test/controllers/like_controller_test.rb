require 'test_helper'

class LikeControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get like_add_url
    assert_response :success
  end

end
