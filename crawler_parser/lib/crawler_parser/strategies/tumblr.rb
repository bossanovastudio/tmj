module CrawlerParser
  class Tumblr
    include Common
    
    def initialize(post)
      @post = post
    end
    
    def run
      card = Card.new
      card.origin     = 'tumblr'
      card.content    = @post.content.summary
      card.source_url = @post.content.short_url
      card.posted_at  = DateTime.strptime(@post.content.timestamp.to_s, '%s')
      card.social_uid = @post.content.blog_name
      
      card.social_user = {
        id: @post.content.blog_name,
        username: @post.content.blog_name
      }
      
      if @post.content.type == 'photo'
        card.media_type = 'Image'
        card.media_id = self.image(self.image_url)
      end
      
      unless card.save
        $logger.error('Error saving card: #{card.inspect}')
      end
    end
    
    def image_url
      @post.content.photos.first.fetch('original_size', {}).fetch('url', nil)
    end
  end
end