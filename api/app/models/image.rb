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

class Image < ApplicationRecord
  # Relationships
  has_many :cards, as: :media

  # Uploader
  mount_uploader :file, ImageUploader
  
  def ratio
    self.width.to_f / self.height.to_f if self.width && self.height
  end
end
