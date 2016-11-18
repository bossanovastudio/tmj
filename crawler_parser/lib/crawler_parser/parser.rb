module CrawlerParser
  class Parser
    def initialize(post)
      @post = post
    end

    def image_url
      if @post.content.respond_to?('entities')
        if @post.content.entities.include?('media')
          unless @post.content.entities['media'].first.nil?
            @post.content.entities['media'].first['media_url'] if @post.content.entities['media'].first['type'] == 'photo'
          end
        end
      elsif @post.content.respond_to?('attachments')
        unless @post.content.attachments.first.nil?
          @post.content.attachments.first['media']['image']['src'] if @post.content.attachments.first['type'] == 'photo'
        end
      elsif @post.content.respond_to?('thumbnails')
        unless @post.content.thumbnails['high'].nil?
          @post.content.thumbnails['high']['url']
        end
      end
    end

    def run
      image_id = self.send('image', self.image_url) unless self.image_url.nil?
      p "social: #{@post.social_media}"
      card = self.send(@post.social_media, @post)
      
      unless image_id.nil?
        card.media_type = 'Image'
        card.media_id   = image_id
      end
      
      unless card.save
        $logger.error('Error saving card: #{card.inspect}')
      end
    end

    private
    def facebook(post)
      card = Card.new
      card.origin     = :facebook
      card.content    = post.content.message
      card.source_url = "https://facebook.com/" + post.social_uuid unless post.social_uuid
      card.posted_at  = post.content.created_time

      card
    end

    def twitter(post)
      card = Card.new
      card.origin     = :twitter
      card.content    = post.content.text
      card.source_url = "https://twitter.com/statuses/" + post.social_uuid unless post.social_uuid
      card.posted_at  = post.content.created_at

      card
    end
    
    def youtube(post)
      card = Card.new
      card.origin     = :youtube
      card.content    = post.content.title
      card.source_url = "https://www.youtube.com/watch?v=" + post.social_uuid unless post.social_uuid
      card.posted_at  = post.content.publishedAt

      card
    end

    def image(url)
      @image = Image.new
      @image.remote_file_url = url
      
      if @image.save
        @image.id
      else
        $logger.error('Error saving image: #{image.inspect}')
      end
    end
  end
end
