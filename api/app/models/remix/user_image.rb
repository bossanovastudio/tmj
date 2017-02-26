# == Schema Information
#
# Table name: remix_user_images
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  uid        :string
#  is_strip   :boolean          default(FALSE)
#

class Remix::UserImage < ApplicationRecord
  after_create :set_uid

  belongs_to :user
  mount_uploader :image, RemixUploader

  validates :image, presence: true
  validates :user, presence: true

  private
    def set_uid
      self.update_attribute(:uid, Digest::SHA1.hexdigest("#{self.id}"))
    end
end
