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
        @twitter.user 'revistadaturma'
        @facebook.timeline 'TurmadaMonicaJovemBrasil'
        @youtube.channel 'revistaturmajovem', true
        # @pinterest.profile ''
      rescue => e
        $logger.error(e)
      end
    end
  end
end
