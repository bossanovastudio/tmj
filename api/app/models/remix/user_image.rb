# == Schema Information
#
# Table name: remix_user_images
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Remix::UserImage < ApplicationRecord
  belongs_to :user
  mount_uploader :image, RemixUploader

  validates :image, presence: true
  validates :user, presence: true
end
