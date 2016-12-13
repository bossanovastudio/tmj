# == Schema Information
#
# Table name: remix_background_colors
#
#  id         :integer          not null, primary key
#  color      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class Remix::BackgroundColorTest < ActiveSupport::TestCase
  def background_color
    @background_color ||= Remix::BackgroundColor.new
  end

  def test_valid
    assert background_color.valid?
  end
end
