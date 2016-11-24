module CrawlerParser
  class Parser
    def initialize(post)
      @post = post
    end

    def run
      card = self.send(@post.social_media, @post)
      
      if card_kind == 'Image'
        card.media_type = card_kind
        card.media_id   = self.send('image', self.image_url)
      elsif card_kind == 'Video'
        card.media_type = card_kind
        card.media_id   = self.send('video', self.video_url, @post.social_media, self.image_url)
      end
      
      unless card.save
        $logger.error('Error saving card: #{card.inspect}')
      end
    end

    def image_url
      if @post.social_media == 'twitter'
        if @post.content.entities.fetch('media', {}).first.fetch('type', '') == 'photo'
          @post.content.entities.fetch('media', {}).first.fetch('media_url', nil)
        end
      elsif @post.social_media == 'facebook'
        if @post.content.attachments.first.fetch('type', '') == 'photo'
          @post.content.attachments.first.fetch('media', {}).fetch('image', {}).fetch('src', nil) 
        end
      elsif @post.social_media == 'youtube'
        @post.content.thumbnails.fetch('high', {}).fetch('url', nil)
      end
    end
    
    def video_url
      if @post.social_media == 'twitter'
        if @post.content.entities.fetch('media', {}).first.fetch('type', '') == 'video'
          @post.content.entities.fetch('media', {}).first.fetch('media_url', nil)
        end
      elsif @post.social_media == 'facebook'
        if @post.content.attachments.first.fetch('type', '') == 'photo'
          @post.content.attachments.first.fetch('media', {}).fetch('video', {}).fetch('src', nil) 
        end
      elsif @post.social_media == 'youtube'
        'https://www.youtube.com/watch?v=' + @post.social_uuid 
      end
    end

    private
    def facebook(post)
      card = Card.new
      card.origin     = 'facebook'
      card.content    = post.content.message
      card.source_url = "https://facebook.com/" + post.social_uuid if post.social_uuid
      card.posted_at  = post.content.created_time
      card.social_user = {
        id: post.content.user.fetch('from', {}).fetch('id', ''),
        username: post.content.user.fetch('from', {}).fetch('name', '')
      }

      card
    end

    def twitter(post)
      card = Card.new
      card.origin     = 'twitter'
      card.content    = post.content.text
      card.source_url = "https://twitter.com/statuses/" + post.social_uuid if post.social_uuid
      card.posted_at  = post.content.created_at
      card.social_user = {
        id: post.content.user.fetch('id', ''),
        username: post.content.user.fetch('screen_name', '')
      }

      card
    end
    
    def youtube(post)
      card = Card.new
      card.origin     = 'youtube'
      card.content    = post.content.title
      card.source_url = "https://www.youtube.com/watch?v=" + post.social_uuid if post.social_uuid
      card.posted_at  = post.content.publishedAt
      card.social_user = {
        id: post.content.channelId,
        username: post.content.channelTitle
      }

      card
    end
    
    def card_kind
      if @post.content.respond_to?('entities')
        if @post.content.entities.include?('media')
          unless @post.content.entities['media'].first.nil?
           'Image' if ['photo', 'video'].include? @post.content.entities['media'].first['type']
          end
        end
      elsif @post.content.respond_to?('attachments')
        unless @post.content.attachments.first.nil?
          'Image' if ['photo', 'video'].include?  @post.content.attachments.first['type']
        end
      elsif @post.social_media == 'youtube'
        'Video'
      else
        'Text'
      end
    end
    
    def image(url)
      @image = Image.new
      @image.remote_file_url = url
      
      if @image.save
        @image.id
      else
        $logger.error('Error saving image: #{@image.inspect}')
      end
    end
    
    def video(url, origin, thumbnail)
      @video = Video.new
      @video.url = url
      @video.origin = origin
      @video.remote_thumbnail_url = thumbnail
      
      if @video.save
        @video.id
      else
        $logger.error('Error saving video: #{@video.inspect}')
      end
    end
  end
end
