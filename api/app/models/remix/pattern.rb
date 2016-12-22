# == Schema Information
#
# Table name: remix_patterns
#
#  id         :integer          not null, primary key
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Remix::Pattern < ApplicationRecord
  mount_uploader :image, RemixUploader

  validates :image, presence: true
end
