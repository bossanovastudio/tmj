require "test_helper"

class SocialNetworkTest < ActiveSupport::TestCase
  def social_network
    @social_network ||= SocialNetwork.new
  end

  def test_valid
    assert social_network.valid?
  end
end
