module CrawlerSocialnetwork
  class CLI
    def initialize
      @facebook  = CrawlerSocialnetwork::Facebook.new
      @twitter   = CrawlerSocialnetwork::Twitter.new
      @youtube   = CrawlerSocialnetwork::Youtube.new
      @pinterest = CrawlerSocialnetwork::Pinterest.new
      @instagram = CrawlerSocialnetwork::Instagram.new
      @tumblr  = CrawlerSocialnetwork::Tumblr.new
    end

    def run
      begin
        @twitter.user 'revistadaturma'
        @facebook.timeline 'TurmadaMonicaJovemBrasil'
        @youtube.channel 'revistaturmajovem', true
        @pinterest.profile 'AWPUOpt6ygJugqlnzdUuNw07dfB-FIuTMID9YAtDl7PBEwAv_gAAAAA'
        [
          '_turmadamonica_',
          'mundo_tmj15',
          'tmj_turmadamonica',
          'tmj_fanclub',
          'monica_ironica',
          'tmjprasempre',
          'tmj_eterno',
          'pride.tmj',
          'forevercascali',
          'monica_a_louca',
          'denisetmj.oficial',
          'cebola20',
          'tmj_4050',
        ].each { |u| @instagram.profile u }

        [
          'turmadamonicaccxp',
          'mspnaccxp',
          'tmj100',
          'turmadamonicajovem',
          'tmjofilme',
          'turmadamonicajovemofilme',
        ].each do |hashtag|
          @instagram.hashtag hashtag
          @twitter.search hashtag
        end
        
        @tumblr.search 'lunetalunatica.tumblr.com'
      rescue => e
        $logger.error(e)
      end
    end
  end
end
