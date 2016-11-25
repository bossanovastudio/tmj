module CrawlerParser
  class Youtube
    include Common
    
    def initialize(post)
      @post = post
    end
    
    def run
      card = Card.new
      card.origin     = 'youtube'
      card.content    = @post.content.title
      card.source_url = "https://www.youtube.com/watch?v=" + @post.social_uuid if @post.social_uuid
      card.posted_at  = @post.content.publishedAt
     
      card.social_user = {
        id: @post.content.channelId,
        username: @post.content.channelTitle
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
      @post.content.thumbnails.fetch('high', {}).fetch('url', nil)
    end
    
    def video_url
      'https://www.youtube.com/watch?v=' + @post.social_uuid
    end
  end
end