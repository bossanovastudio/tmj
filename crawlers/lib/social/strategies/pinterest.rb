module Crawlers::Social
  class Pinterest
    def profile(access_token=nil)
      raise ::RuntimeError unless access_token
      @conn = ::Pinterest::Client.new access_token

      data = nil
      begin
        @conn.get_pins({fields: 'id,link,note,url,attribution,board,metadata,original_link,color,counts,created_at,creator,image,media'}).data
      rescue Exception => e
        $logger.error("Error saving pin: #{e}")
      end
      return unless data
      data.each do |pin|
        unless CrawledPost.find_by_social_uuid(pin.id)
          crawled_post = CrawledPost.new
          crawled_post.social_media = :pinterest
          crawled_post.social_uuid  = pin.id
          crawled_post.data = pin.to_h

          unless crawled_post.save
            $logger.error("Error saving tweet: #{tweet.inspect}")
          end
        end
      end
    end
  end
end
