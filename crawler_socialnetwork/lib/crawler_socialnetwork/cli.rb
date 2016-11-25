module CrawlerSocialnetwork
  class CLI
    def initialize
      @facebook = CrawlerSocialnetwork::Facebook.new
      @twitter  = CrawlerSocialnetwork::Twitter.new
      @youtube  = CrawlerSocialnetwork::Youtube.new
      @pinterest  = CrawlerSocialnetwork::Pinterest.new
    end

    def run
      begin
        @twitter.tweets '#turmadamonicajovem'
        @facebook.timeline 'revistaturmadamonicajovem'
        @youtube.channel 'UCekYMr9EQSauMefFzMTrpSg'
        @pinterest.profile 'ATyVVvsSMywB5qUMpw2cqM2fclgFFIpb4l6oJfhDlSbqhyAsBgAAAAA'
      rescue => e
        $logger.error(e)
      end
    end
  end
end
