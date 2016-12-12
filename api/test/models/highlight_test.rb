# == Schema Information
#
# Table name: highlights
#
#  id               :integer          not null, primary key
#  content          :text
#  posted_at        :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  source_url       :string
#  size             :integer          default("one")
#  index            :integer          default(0)
#  published        :boolean
#  desktop_image_id :integer
#  mobile_image_id  :integer
#

require "test_helper"

class HighlightTest < ActiveSupport::TestCase
  def highlight
    @highlight ||= Highlight.new
  end

  def test_valid
    assert highlight.valid?
  end
end
