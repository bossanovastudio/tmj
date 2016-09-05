class Image < ApplicationRecord
  # Relationships
  has_many :cards, as: :media

  # Uploader
  mount_uploader :file, ImageUploader
end
