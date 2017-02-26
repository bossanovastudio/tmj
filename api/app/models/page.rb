# == Schema Information
#
# Table name: pages
#
#  id              :integer          not null, primary key
#  slug            :string
#  title           :string
#  keywords        :string
#  description     :string
#  content         :text
#  background_menu :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  background_page :string
#

class Page < ApplicationRecord
  validates :title, presence: true
  validates :slug, presence: true, uniqueness: true

  mount_uploader :background_menu, PageAssetUploader
  mount_uploader :background_page, PageAssetUploader

end
