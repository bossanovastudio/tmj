class Card < ApplicationRecord
  belongs_to :media, polymorphic: true
end
