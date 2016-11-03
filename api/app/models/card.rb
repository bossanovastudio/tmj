class Card < ApplicationRecord
  enum origin: { facebook: 1, twitter: 2 }
  belongs_to :media, polymorphic: true
  belongs_to :user
end
