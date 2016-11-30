# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  width      :integer          default(1), not null
#  height     :integer          default(1), not null
#

require "test_helper"

class ImageTest < ActiveSupport::TestCase
  def image
    @image ||= Image.new
  end

  def test_valid
    assert image.valid?
  end
end
