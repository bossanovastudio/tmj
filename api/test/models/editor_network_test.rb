# == Schema Information
#
# Table name: editor_networks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  kind       :integer
#  url        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class EditorNetworkTest < ActiveSupport::TestCase
  def editor_network
    @editor_network ||= EditorNetwork.new
  end

  def test_valid
    assert editor_network.valid?
  end
end
