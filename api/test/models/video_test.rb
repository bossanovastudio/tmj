# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  url        :string
#  origin     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  thumbnail  :string
#  width      :integer          default(1), not null
#  height     :integer          default(1), not null
#

require "test_helper"

class VideoTest < ActiveSupport::TestCase
  def video
    @video ||= Video.new
  end

  def test_valid
    assert video.valid?
  end
end
