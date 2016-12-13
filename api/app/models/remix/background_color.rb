# == Schema Information
#
# Table name: remix_background_colors
#
#  id         :integer          not null, primary key
#  color      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Remix::BackgroundColor < ApplicationRecord
  validates :color, presence: true, uniqueness: true
end
