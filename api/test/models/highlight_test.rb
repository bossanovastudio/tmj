# == Schema Information
#
# Table name: highlights
#
#  id                :integer          not null, primary key
#  content           :text
#  media_type        :string
#  media_id          :integer
#  posted_at         :datetime
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  source_url        :string
#  size              :integer          default("one")
#  mobile_media_id   :integer
#  mobile_media_type :string
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
