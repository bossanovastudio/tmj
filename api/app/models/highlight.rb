# == Schema Information
#
# Table name: highlights
#
#  id               :integer          not null, primary key
#  content          :text
#  posted_at        :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  source_url       :string
#  size             :integer          default("one")
#  index            :integer          default(0)
#  published        :boolean
#  desktop_image_id :integer
#  mobile_image_id  :integer
#

class Highlight < ApplicationRecord
  enum size: { one: 1, two: 2, three: 3, four: 4, five: 5 }
  belongs_to :desktop_image, class_name: "Image"
  belongs_to :mobile_image, class_name: "Image"

  scope :published, -> { where(published: true) }
  before_validation :ensure_index

  def self.move_to_index(id, new_index)
    to_move = Highlight.find(id)
    Highlight.transaction do
      Highlight.where('index >= ?', new_index).each do |h|
        h.index += 1
        h.save!
      end
      to_move.index = new_index
      to_move.save!
    end
  end

  private
    def ensure_index
      h = Highlight.all.order(index: :desc).first
      unless h
        self.index = 1
      else
        self.index = h.index + 1
      end
    end
end
