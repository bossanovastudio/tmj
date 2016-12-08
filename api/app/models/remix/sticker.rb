# == Schema Information
#
# Table name: remix_stickers
#
#  id         :integer          not null, primary key
#  image      :string
#  kind       :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Remix::Sticker < ApplicationRecord
  enum kind: [:speech_balloon, :common_sticker]
  mount_uploader :image, RemixUploader

  validates :image, presence: true
  validates :kind, presence: true
end
