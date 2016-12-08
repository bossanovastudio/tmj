# == Schema Information
#
# Table name: remix_stickers
#
#  id         :integer          not null, primary key
#  image      :string
#  type       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Remix::Sticker < ApplicationRecord
  enum type: [:speech_balloon, :common_sticker]
  mount_uploader :image, RemixUploader

  validates :image, presence: true
  validates :type, presence: true
end
