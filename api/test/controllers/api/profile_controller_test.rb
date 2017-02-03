require "test_helper"

class Api::ProfileControllerTest < ActionDispatch::IntegrationTest
  def test_index
    get api_profile_index_url
    assert_response :success
  end

end
