require "test_helper"

class VideoTest < ActiveSupport::TestCase
  def video
    @video ||= Video.new
  end

  def test_valid
    assert video.valid?
  end
end
