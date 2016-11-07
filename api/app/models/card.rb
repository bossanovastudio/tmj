class Card < ApplicationRecord
  enum origin: { facebook: 1, twitter: 2 }
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
