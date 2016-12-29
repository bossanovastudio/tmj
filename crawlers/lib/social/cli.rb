module Crawlers::Social
  class CLI
    def initialize
      @facebook  = Crawlers::Social::Facebook.new
      @twitter   = Crawlers::Social::Twitter.new
      @youtube   = Crawlers::Social::Youtube.new
      @pinterest = Crawlers::Social::Pinterest.new
      @instagram = Crawlers::Social::Instagram.new
      @tumblr    = Crawlers::Social::Tumblr.new
    end

    def guard
      begin
        yield if block_given?
      rescue Exception => e
        $logger.error(e)
      end
    end

    def run
      [
        'TurmadaMonicaJovemBrasil',
        'DoContradc',
        'fasdeturmadamonicajovem',
        'emersonabreu.msp',
        'amamostmjforever',
        'tmjdiversidades',
        'OpiniaoTMJ',
        'tmjmania',
        'tmjjunto',
        'TMJN0vos',
        'tmjdivertidos',
        'TMJ-CBM-Mania-1443398202598155',
      ].each { |u| guard { @facebook.timeline u } }

      [
        'OpiniaoTMJ',
        'diariodorick',
        'revistaturmajovem',
      ].each { |u| guard { @youtube.channel u, true } }

      [
        'UCekYMr9EQSauMefFzMTrpSg',
        'UCpf5c40cP3MoXe2T81zb4xA',
        'UCIfAeO5OrsuxczdozQ5mcag',
      ].each { |u| guard { @youtube.channel u } }

      guard { @tumblr.search 'lunetalunatica.tumblr.com' }
      guard { @pinterest.profile 'AWPUOpt6ygJugqlnzdUuNw07dfB-FIuTMID9YAtDl7PBEwAv_gAAAAA' }

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
      ].each { |u| guard { @instagram.profile u } }

      guard { @twitter.user 'revistadaturma' }

      [
        'turmadamonicaccxp',
        'mspnaccxp',
        'tmj100',
        'turmadamonicajovem',
        'tmjofilme',
        'turmadamonicajovemofilme',
      ].each do |hashtag|
        guard { @instagram.hashtag hashtag }
        guard { @twitter.search "##{hashtag}" }
      end
    end
  end
end
