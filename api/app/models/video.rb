class Video < ApplicationRecord
  # Relationships
  has_many :cards, as: :media

  # Uploader
  mount_uploader :thumbnail, ImageUploader
  
  # Field Enum
  enum origin: { facebook: 1, youtube: 3, vimeo: 4 }
end
