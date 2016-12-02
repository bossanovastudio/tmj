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
        @facebook.timeline 'TurmadaMonicaJovemBrasil'
        @youtube.channel 'revistaturmajovem', true
        @tumblr.search 'lunetalunatica.tumblr.com'
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
        
        @twitter.user 'revistadaturma'
        
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
      rescue => e
        $logger.error(e)
      end
    end
  end
end
