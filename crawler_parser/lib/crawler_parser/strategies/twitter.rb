module CrawlerParser
  class Twitter
    include Common
    
    def initialize(post)
      @post = post
    end
    
    def run
      card = Card.new
      card.origin     = 'twitter'
      card.content    = @post.content.text
      card.source_url = "https://twitter.com/statuses/" + @post.social_uuid if @post.social_uuid
      card.posted_at  = @post.content.created_at
      card.social_user = {
        id: @post.content.user.fetch('id', ''),
        username: @post.content.user.fetch('screen_name', '')
      }
      
      if @post.kind == :image
        card.media_type = 'Image'
        card.media_id = self.image(self.image_url)
      elsif @post.kind == 'Video'
        card.media_type = 'Video'
        card.media_id = self.video(self.video_url, @post.social_media, self.image_url)
      end
      
      unless card.save
        $logger.error('Error saving card: #{card.inspect}')
      end
    end
    
    def image_url
      if @post.content.entities.fetch('media', {}).first.fetch('type', '') == 'photo'
        @post.content.entities.fetch('media', {}).first.fetch('media_url', nil)
      end
    end
    
    def video_url
      if @post.content.entities.fetch('media', {}).first.fetch('type', '') == 'video'
        @post.content.entities.fetch('media', {}).first.fetch('media_url', nil)
      end
    end
  end
end