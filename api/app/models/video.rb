class Video < ApplicationRecord
  # Relationships
  has_many :cards, as: :media

  # Field Enum
  enum origin: { youtube: 1, vimeo: 2 }
end
