module CrawlerSocialnetwork
  class CLI
    def initialize
      @facebook = CrawlerSocialnetwork::Facebook.new
      @twitter  = CrawlerSocialnetwork::Twitter.new
    end

    def run
      @twitter.tweets '#turmadamonicajovem'
      @facebook.timeline 'revistaturmadamonicajovem'
    end
  end
end
