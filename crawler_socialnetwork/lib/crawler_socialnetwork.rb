require "logger"

require "koala"
require "twitter"
require "active_record"

require "crawler_socialnetwork/version"
require "crawler_socialnetwork/facebook"
require "crawler_socialnetwork/twitter"
require "crawler_socialnetwork/models/application_record"
require "crawler_socialnetwork/models/crawled_post"
require "crawler_socialnetwork/cli"

module CrawlerSocialnetwork
  $logger = Logger.new(STDOUT)
  $logger.level = Logger::WARN
end
