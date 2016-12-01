# == Schema Information
#
# Table name: providers
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class ProviderTest < ActiveSupport::TestCase
  def provider
    @provider ||= Provider.new
  end

  def test_valid
    assert provider.valid?
  end
end
