# == Schema Information
#
# Table name: videos
#
#  id         :integer          not null, primary key
#  url        :string
#  origin     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  thumbnail  :string
#  width      :integer          default(1), not null
#  height     :integer          default(1), not null
#

class Video < ApplicationRecord
  # Relationships
  has_many :cards, as: :media

  # Uploader
  mount_uploader :thumbnail, ImageUploader
  
  # Field Enum
  enum origin: { facebook: 1, youtube: 3, vimeo: 4 }
end
