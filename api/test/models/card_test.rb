# == Schema Information
#
# Table name: cards
#
#  id                  :integer          not null, primary key
#  origin              :integer
#  content             :text
#  media_type          :string
#  media_id            :integer
#  posted_at           :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  source_url          :string
#  size                :integer          default("one")
#  social_user         :json
#  social_uid          :string
#  remix_image_id      :integer
#  moderation_metadata :json
#

require "test_helper"

class CardTest < ActiveSupport::TestCase
  def card
    @card ||= Card.new
  end

  def test_valid
    assert card.valid?
  end
end
