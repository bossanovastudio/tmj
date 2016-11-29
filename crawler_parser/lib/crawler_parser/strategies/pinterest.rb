require 'pp'
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
      card.social_uid = @post.content.creator.fetch('id', '')

      card.social_user = {
        id: @post.content.creator.fetch('id', ''),
        username: @post.content.creator.fetch('url', '').match(/(https|http):\/\/www.pinterest.com\/([a-zA-Z0-9.]*)\//)[2]
      }
      
      card.media_type = 'Image'
      card.media_id = self.image(self.image_url)
      
      unless card.save
        $logger.error('Error saving card: #{card.inspect}')
      end
    end
    
    def image_url
      if @post.content.respond_to?('media')
        if @post.content.media.fetch('type', '') == 'image'
          @post.content.image.fetch('original', {}).fetch('url', nil)
        end
      end
    end
  end
end