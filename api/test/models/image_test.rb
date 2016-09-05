require "test_helper"

class ImageTest < ActiveSupport::TestCase
  def image
    @image ||= Image.new
  end

  def test_valid
    assert image.valid?
  end
end
