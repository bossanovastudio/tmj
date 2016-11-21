class Highlight < ApplicationRecord
  enum size: { one: 1, two: 2, three: 3, four: 4, five: 5 }
  belongs_to :media, polymorphic: true
end
