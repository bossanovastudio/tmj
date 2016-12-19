require "test_helper"

class ShareControllerTest < ActionDispatch::IntegrationTest
  def test_card
    get share_card_url
    assert_response :success
  end

  def test_profile
    get share_profile_url
    assert_response :success
  end

end
