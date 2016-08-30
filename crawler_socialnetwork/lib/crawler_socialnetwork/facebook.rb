module CrawlerSocialnetwork
  class Facebook
    def initialize
      tokens = {}
      tokens[:facebook_app_id]     = ENV.fetch 'FACEBOOK_APP_ID'
      tokens[:facebook_app_secret] = ENV.fetch 'FACEBOOK_APP_SECRET'

      conn = Koala::Facebook::OAuth.new(tokens[:facebook_app_id], tokens[:facebook_app_secret])
      @graph = Koala::Facebook::API.new(conn.get_app_access_token, tokens[:facebook_app_secret])
    end

    def timeline(user_id=nil)
      raise RuntimeError unless user_id

      feed = @graph.get_connections(user_id, "feed")

      feed.each do |post|
        unless CrawledPost.find_by_social_uuid(post['id'])
          post['attachments'] = @graph.get_object("/#{post['id']}/attachments")

          crawled_post = CrawledPost.new
          crawled_post.social_media = :facebook
          crawled_post.social_uuid  = post['id']
          crawled_post.data = post

          unless crawled_post.save
            $logger.error('Error saving post: #{post.inspect}')
          end
        end
      end
    end
  end
end
