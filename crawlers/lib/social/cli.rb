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
      runs = {
        tumblr: [],
        facebook: [],
        youtube: [],
        twitter: [],
        instagram: []
      }
      editors = EditorProvider.all
      editors.each do |e|
        e.providers.each do |p|
          k = p.provider.to_sym
          unless runs.key? k
            puts "WARNING! Cannot handle provider with type #{k}"
            next
          end
          runs[k] << p.uid
        end
      end

      # Basic normalisation
      runs[:tumblr] = runs[:tumblr].collect { |e| "#{e}.tumblr.com" }

      # Associate with static data
      runs.keys.each do |k|
        runs[k] = (runs[k] + Statics::RUNS[k]).uniq
      end

      puts runs

      runs[:tumblr].each { |u| guard { @tumblr.search u } }
      runs[:facebook].each { |u| guard { @facebook.timeline u } }
      runs[:youtube].each { |u| guard { @youtube.channel u, !u.start_with?('UC') } }
      runs[:twitter].each { |u| guard { @twitter.user u } }
      runs[:instagram].each { |u| guard { @instagram.profile u } }

      # This is still here because the implemented providers mechanism does not
      # store keys required for pinterest profiles work correctly.
      guard { @pinterest.profile 'AWPUOpt6ygJugqlnzdUuNw07dfB-FIuTMID9YAtDl7PBEwAv_gAAAAA' }

      Statics::HASHTAGS.each do |hashtag|
        guard { @instagram.hashtag hashtag }
        guard { @twitter.search "##{hashtag}" }
      end

      runs[:facebook].each { |u| guard { @facebook.timeline u, Statics::HASHTAGS } }
    end
  end
end
