require "test_helper"

class CastingTest < ActiveSupport::TestCase
  def casting
    @casting ||= Casting.new
  end

  def test_valid
    assert casting.valid?
  end
end
