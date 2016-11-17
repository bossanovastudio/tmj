module CrawlerSocialnetwork
  class CLI
    def initialize
      @facebook = CrawlerSocialnetwork::Facebook.new
      @twitter  = CrawlerSocialnetwork::Twitter.new
      @youtube  = CrawlerSocialnetwork::Youtube.new
    end

    def run
      begin
        @twitter.tweets '#turmadamonicajovem'
        @facebook.timeline 'revistaturmadamonicajovem'
        @youtube.channel 'UCekYMr9EQSauMefFzMTrpSg'
      rescue => e
        $logger.error(e)
      end
    end
  end
end
