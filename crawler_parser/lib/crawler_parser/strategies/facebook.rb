module CrawlerParser
  class Facebook
    include Common
    
    def initialize(post)
      @post = post
    end
    
    def run
      card = Card.new
      card.origin     = 'facebook'
      card.content    = @post.content.message
      card.source_url = "https://facebook.com/" + @post.social_uuid if @post.social_uuid
      card.posted_at  = @post.content.created_time
      card.social_uid = @post.content.user.fetch('from', {}).fetch('id', '')
      
      card.social_user = {
        id: @post.content.user.fetch('from', {}).fetch('id', ''),
        username: @post.content.user.fetch('from', {}).fetch('name', '')
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
      if @post.content.attachments.first.fetch('type', '') == 'photo'
        @post.content.attachments.first.fetch('media', {}).fetch('image', {}).fetch('src', nil) 
      end
    end
    
    def video_url
      if @post.content.attachments.first.fetch('type', '') == 'video'
        @post.content.attachments.first.fetch('media', {}).fetch('video', {}).fetch('src', nil) 
      end
    end
  end
end