module CrawlerSocialnetwork
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

    def tweets
      conn.search("#turmadamonicajovem", lang: "pt-br").each do |status|
        tweet = conn.status(status.id)
        tweet
      end
    end
  end
end
