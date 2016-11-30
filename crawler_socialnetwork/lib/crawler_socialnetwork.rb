require "logger"

require "koala"
require "twitter"
require "google/api_client"
require "active_record"
require "pinterest-api"
require "httparty"
require "tumblr_client"

require "crawler_socialnetwork/version"

require "crawler_socialnetwork/strategies/facebook"
require "crawler_socialnetwork/strategies/twitter"
require "crawler_socialnetwork/strategies/youtube"
require "crawler_socialnetwork/strategies/pinterest"
require "crawler_socialnetwork/strategies/instagram"
require "crawler_socialnetwork/strategies/tumblr"

require "crawler_socialnetwork/models/application_record"
require "crawler_socialnetwork/models/crawled_post"
require "crawler_socialnetwork/cli"

module CrawlerSocialnetwork
  $logger = Logger.new(STDOUT)
  $logger.level = Logger::WARN
end
