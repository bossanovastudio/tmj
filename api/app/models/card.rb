# == Schema Information
#
# Table name: cards
#
#  id             :integer          not null, primary key
#  origin         :integer
#  content        :text
#  media_type     :string
#  media_id       :integer
#  posted_at      :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  source_url     :string
#  status         :integer          default("pending")
#  size           :integer          default("one")
#  social_user    :json
#  social_uid     :string
#  remix_image_id :integer
#

class Card < ApplicationRecord
  enum origin: { facebook: 1, twitter: 2, youtube: 3, vimeo: 4, instagram: 5, pinterest: 6, tumblr: 7 }
  enum size: { one: 1, two: 2, three: 3, four: 4, five: 5 }
  enum status: { pending: 1, accepted: 2, rejected: 3 }
  belongs_to :media, polymorphic: true
  belongs_to :provider, foreign_key: 'social_uid', primary_key: 'uid'
  has_one :user, through: :provider
  belongs_to :remix_image, class_name: "Remix::UserImage"

  scope :ordered, -> { order(posted_at: 'DESC') }
  scope :approved, -> { where(status: :accepted) }
  scope :not_rejected, -> { where.not(status: :rejected) }

  def self.filter_query(params)
    options = {}
    if params.present?
      params.each do |field|
        options[field] = params[field] unless params[field].empty?
      end
    end
    if options.present?
      left_joins(:provider).where(options)
    else
       all  ## or nil if you don't want to show any records in view
    end
  end

  def kind
    if media_type == 'Image'
      :image
    elsif media_type == 'Video'
      :video
    else
      :text
    end
  end

  def is_from_remix?
    !remix_image.nil?
  end

  def first_recommended_by
    self.liked_by.where(role: :editor).first
  end

  def recommended_by_editor?
    !first_recommended_by.nil?
  end
end
