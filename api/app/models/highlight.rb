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

class Highlight < ApplicationRecord
  enum size: { one: 1, two: 2, three: 3, four: 4, five: 5 }
  belongs_to :desktop_image, class_name: "Image"
  belongs_to :mobile_image, class_name: "Image"

  scope :published, -> { where(published: true) }
end
