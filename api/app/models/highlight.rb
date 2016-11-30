# == Schema Information
#
# Table name: highlights
#
#  id         :integer          not null, primary key
#  content    :text
#  media_type :string
#  media_id   :integer
#  posted_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  source_url :string
#  size       :integer          default("one")
#

class Highlight < ApplicationRecord
  enum size: { one: 1, two: 2, three: 3, four: 4, five: 5 }
  belongs_to :media, polymorphic: true
end
