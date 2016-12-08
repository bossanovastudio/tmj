# == Schema Information
#
# Table name: remix_images
#
#  id                :integer          not null, primary key
#  remix_category_id :integer
#  image             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Remix::Image < ApplicationRecord
  mount_uploader :image, RemixUploader

  belongs_to :category, class_name: "Remix::Category", foreign_key: :remix_category_id
end
