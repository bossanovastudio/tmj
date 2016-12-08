# == Schema Information
#
# Table name: remix_stickers
#
#  id         :integer          not null, primary key
#  image      :string
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require "test_helper"

class Remix::StickerTest < ActiveSupport::TestCase
  def sticker
    @sticker ||= Remix::Sticker.new
  end

  def test_valid
    assert sticker.valid?
  end
end
