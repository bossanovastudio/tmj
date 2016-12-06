module Crawlers::Social
  class Tumblr
    def initialize
      tokens = {}
      tokens[:tumblr_api_key]        = ENV.fetch 'TUMBLR_API_KEY'
      tokens[:tumblr_secret_key]     = ENV.fetch 'TUMBLR_SECRET_KEY'
      tokens[:tumblr_token]        = ENV.fetch 'TUMBLR_TOKEN'
      tokens[:tumblr_token_secret] = ENV.fetch 'TUMBLR_TOKEN_SECRET'

      ::Tumblr.configure do |config|
        config.consumer_key = tokens[:tumblr_api_key]
        config.consumer_secret = tokens[:tumblr_secret_key]
        config.oauth_token = tokens[:tumblr_token]
        config.oauth_token_secret = tokens[:tumblr_token_secret]
      end

      @conn = ::Tumblr.new
    end

    def search(blog = nil)
      raise ::RuntimeError unless blog

      @conn.posts(blog).fetch('posts', []).each do |post|
        unless CrawledPost.find_by_social_uuid(post.fetch('id', ''))

          crawled_post = CrawledPost.new
          crawled_post.social_media = :tumblr
          crawled_post.social_uuid  = post.fetch('id', '')
          crawled_post.data = post

          unless crawled_post.save
            $logger.error("Error saving tumblr: #{post.inspect}")
          end
        end
      end
    end
  end
end
