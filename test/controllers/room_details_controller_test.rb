require 'test_helper'

class RoomDetailsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get room_details_index_url
    assert_response :success
  end

end
