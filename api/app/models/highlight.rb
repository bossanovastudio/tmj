class Highlight < ApplicationRecord
  belongs_to :media, polymorphic: true
end
