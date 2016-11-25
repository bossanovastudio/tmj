module CrawlerParser
  class Pinterest
    include Common
    
    def initialize(post)
      @post = post
    end
    
    def run
      card = Card.new
      card.origin     = 'pinterest'
      card.content    = @post.content.note
      card.source_url = @post.content.url
      card.posted_at  = @post.content.created_at

      card.social_user = {
        id: @post.content.creator.fetch('id', ''),
        username: @post.content.creator.fetch('url', '').match(/(https|http):\/\/www.pinterest.com\/([a-zA-Z0-9.]*)\//)[1]
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
      if @post.content.image.fetch('original', {}).fetch('type', '') == 'photo'
        @post.content.image.fetch('original', {}).fetch('url', nil)
      end
    end
  end
end