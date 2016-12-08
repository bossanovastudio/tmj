# == Schema Information
#
# Table name: remix_text_colors
#
#  id         :integer          not null, primary key
#  foreground :string
#  background :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class Remix::TextColorTest < ActiveSupport::TestCase
  def text_color
    @text_color ||= Remix::TextColor.new
  end

  def test_valid
    assert text_color.valid?
  end
end
