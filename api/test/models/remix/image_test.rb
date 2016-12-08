# == Schema Information
#
# Table name: remix_images
#
#  id                :integer          not null, primary key
#  remix_category_id :integer
#  image             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require "test_helper"

class Remix::ImageTest < ActiveSupport::TestCase
  def image
    @image ||= Remix::Image.new
  end

  def test_valid
    assert image.valid?
  end
end
