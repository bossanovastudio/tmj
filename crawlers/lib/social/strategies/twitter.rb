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

      @last_post = CrawledPost.where(social_media: :twitter).order(social_uuid: :desc).first
    end

    def user(username = nil)
      raise ::RuntimeError unless username

      puts "Twitter#user for #{username}"
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

      puts "Twitter#search for #{search_term}"
      since_id = 0
      since_id = @last_post.social_uuid if @last_post

      puts "'since_id:' #{since_id}"
      @conn.search(search_term, result_type: 'recent', count: 100, since_id: since_id).each do |status|
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
