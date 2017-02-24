module Crawlers::Social
  class Statics
    FACEBOOK_TIMELINES = [
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
    ].freeze

    YOUTUBE_USER_CHANNELS = [
      'OpiniaoTMJ',
      'diariodorick',
      'revistaturmajovem',
    ].freeze

    YOUTUBE_CHANNELS = [
      'UCekYMr9EQSauMefFzMTrpSg',
      'UCpf5c40cP3MoXe2T81zb4xA',
      'UCIfAeO5OrsuxczdozQ5mcag',
    ].freeze

    INSTAGRAM_PROFILES = [
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
      'instadaramona',
    ].freeze

    TWITTER_USERS = [
      'revistadaturma'
    ].freeze

    HASHTAGS = [
      'turmadamonicaccxp',
      'mspnaccxp',
      'tmj100',
      'turmadamonicajovem',
      'tmjofilme',
      'turmadamonicajovemofilme',
    ].freeze

    RUNS = {
      tumblr: [],
      facebook: FACEBOOK_TIMELINES,
      youtube: YOUTUBE_CHANNELS + YOUTUBE_USER_CHANNELS,
      twitter: TWITTER_USERS,
      instagram: INSTAGRAM_PROFILES,
    }.freeze
  end
end
