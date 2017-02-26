# == Schema Information
#
# Table name: remix_user_images
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uid        :string
#  is_strip   :boolean          default(FALSE)
#

require "test_helper"

class Remix::UserImageTest < ActiveSupport::TestCase
  def user_image
    @user_image ||= Remix::UserImage.new
  end

  def test_valid
    assert user_image.valid?
  end
end
