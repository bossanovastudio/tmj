# == Schema Information
#
# Table name: social_networks
#
#  id         :integer          not null, primary key
#  name       :string
#  origin     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class SocialNetworkTest < ActiveSupport::TestCase
  def social_network
    @social_network ||= SocialNetwork.new
  end

  def test_valid
    assert social_network.valid?
  end
end
