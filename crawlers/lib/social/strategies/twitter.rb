module Crawlers::Social
  class Twitter
    def initialize
      tokens = {}
      tokens[:consumer_key]        = ENV.fetch 'TWITTER_CONSUMER_KEY'
      tokens[:consumer_secret]     = ENV.fetch 'TWITTER_CONSUMER_SECRET'
      tokens[:access_token]        = ENV.fetch 'TWITTER_ACCESS_TOKEN'
      tokens[:access_token_secret] = ENV.fetch 'TWITTER_ACCESS_TOKEN_SECRET'

      @conn = ::Twitter::REST::Client.new do |config|
        config.consumer_key         = tokens[:consumer_key]
        config.consumer_secret      = tokens[:consumer_secret]
        config.access_token         = tokens[:access_token]
        config.access_token_secret  = tokens[:access_token_secret]
      end
    end

    def user(username = nil)
      raise ::RuntimeError unless username

      @conn.user_timeline(username).each do |status|
        unless CrawledPost.find_by_social_uuid(status.id)
          tweet = @conn.status(status.id)

          crawled_post = CrawledPost.new
          crawled_post.social_media = :twitter
          crawled_post.social_uuid  = status.id
          crawled_post.data = tweet

          unless crawled_post.save
            $logger.error("Error saving tweet: #{tweet.inspect}")
          end
        end
      end
    end

    def search(search_term = nil)
      raise ::RuntimeError unless search_term

      @conn.search(search_term, result_type: 'recent').each do |status|
        unless CrawledPost.find_by_social_uuid(status.id)
          tweet = @conn.status(status.id)

          crawled_post = CrawledPost.new
          crawled_post.social_media = :twitter
          crawled_post.social_uuid  = status.id
          crawled_post.data = tweet

          unless crawled_post.save
            $logger.error("Error saving <twe></twe>et: #{tweet.inspect}")
          end
        end
      end
    end
  end
end
