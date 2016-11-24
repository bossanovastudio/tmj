class Card < ApplicationRecord
  enum origin: { facebook: 1, twitter: 2, youtube: 3, vimeo: 4, instagram: 5 }
  enum size: { one: 1, two: 2, three: 3, four: 4, five: 5 }
  enum status: { pending: 1, accepted: 2, rejected: 3 }
  belongs_to :media, polymorphic: true
  belongs_to :user

  scope :ordered, -> { order(posted_at: 'DESC') }
  
  def self.filter_query(params)
    options = {}
    if params.present?
      params.each do |field|
        options[field] = params[field] unless params[field].empty?
      end
    end
    if options.present?
      where(options)
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
end
