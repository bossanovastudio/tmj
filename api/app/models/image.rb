class Image < ApplicationRecord
  # Relationships
  has_many :cards, as: :media

  # Uploader
  mount_uploader :file, ImageUploader
  
  def ratio
    self.width.to_f / self.height.to_f if self.width && self.height
  end
end
