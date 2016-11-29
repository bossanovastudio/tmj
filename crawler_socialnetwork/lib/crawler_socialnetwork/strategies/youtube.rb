module CrawlerSocialnetwork
  class Youtube
    def initialize
      @conn = Google::APIClient.new(
        key: ENV.fetch('GOOGLE_API_KEY'),
        authorization: nil,
        application_name: ENV.fetch('GOOGLE_APP_NAME'),
        application_version: '1.0.0'
      )

      @youtube = @conn.discovered_api('youtube', 'v3')
    end
    
    def channel(channel_id, is_user = false)
      raise RuntimeError unless channel_id
      
      if is_user
        channel_response = @conn.execute!(
          api_method: @youtube.channels.list,
          parameters: {
            part: 'contentDetails',
            forUsername: channel_id
          }
        )
        
        channel_id = channel_response.data.items.first.id
      end
      
      videos = @conn.execute!(
        api_method: @youtube.search.list,
        parameters: {
          part: 'snippet',
          channelId: channel_id
        }
      )

      videos.data.items.each do |video|
        if video.id.kind == 'youtube#video'
          unless CrawledPost.find_by_social_uuid(video.id.videoId)
            crawled_post = CrawledPost.new
            crawled_post.social_media = :youtube
            crawled_post.social_uuid = video.id.videoId
            crawled_post.data = video.snippet

            unless crawled_post.save
              $logger.error('Error saving post: #{post.inspect}')
            end
          end
        end
      end
    end
  end
end