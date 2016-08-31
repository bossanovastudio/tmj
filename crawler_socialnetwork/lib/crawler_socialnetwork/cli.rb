module CrawlerSocialnetwork
  class CLI
    def initialize
      @facebook = CrawlerSocialnetwork::Facebook.new
      @twitter  = CrawlerSocialnetwork::Twitter.new
    end

    def run
      begin
        @twitter.tweets '#turmadamonicajovem'
        @facebook.timeline 'revistaturmadamonicajovem'
      rescue => e
        $logger.error(e)
      end
    end
  end
end
