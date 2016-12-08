# == Schema Information
#
# Table name: remix_categories
#
#  id         :integer          not null, primary key
#  cover      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Remix::Category < ApplicationRecord
  validates :name, presence: true
  validates :cover, presence: true

  mount_uploader :cover, RemixUploader

  has_many :images, class_name: "Remix::Image", foreign_key: :remix_category_id
end
