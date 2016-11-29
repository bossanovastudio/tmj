require "test_helper"

class ProviderTest < ActiveSupport::TestCase
  def provider
    @provider ||= Provider.new
  end

  def test_valid
    assert provider.valid?
  end
end
