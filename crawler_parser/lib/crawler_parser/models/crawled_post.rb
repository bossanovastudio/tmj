class CrawledPost < CrawlerRecord
  enum social_media: { facebook: 1, twitter: 2, youtube: 3, vimeo: 4, instagram: 5, pinterest: 6 }

  def content
    OpenStruct.new self.data
  end
  
  def kind
    if self.content.respond_to?('entities')
      if self.content.entities.include?('media')
        unless self.content.entities['media'].first.nil?
          if self.content.entities['media'].first['type'] == 'photo'
            :image
          elsif self.content.entities['media'].first['type'] == 'video'
            :video
          end
        end
      end
    elsif self.content.respond_to?('attachments')
      unless self.content.attachments.first.nil?
        if self.content.attachments.first['type'] == 'photo'
          :image
        elsif self.content.attachments.first['type'] == 'video'
          :video
        end
      end
    elsif self.social_media == 'youtube'
      :video
    else
      :video
    end
  end
end
