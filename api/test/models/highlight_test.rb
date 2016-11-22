require "test_helper"

class HighlightTest < ActiveSupport::TestCase
  def highlight
    @highlight ||= Highlight.new
  end

  def test_valid
    assert highlight.valid?
  end
end
