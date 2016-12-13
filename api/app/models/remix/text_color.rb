# == Schema Information
#
# Table name: remix_text_colors
#
#  id         :integer          not null, primary key
#  foreground :string
#  background :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Remix::TextColor < ApplicationRecord
  validates :foreground, presence: true, uniqueness: { scope: :background }
  validates :background, presence: true
end
