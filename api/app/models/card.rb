class Card < ApplicationRecord
  enum origin: { facebook: 1, twitter: 2, youtube: 3, vimeo: 4, instagram: 5 }
  enum size: { one: 1, two: 2, three: 3, four: 4, five: 5 }
  belongs_to :media, polymorphic: true
  belongs_to :user
  
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
