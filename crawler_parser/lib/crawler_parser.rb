require "logger"
require "ostruct"

require "active_record"
require "active_resource"

require "crawler_parser/version"
require "crawler_parser/models/crawler_record"
require "crawler_parser/models/crawled_post"
require "crawler_parser/models/card"
require "crawler_parser/models/image"
require "crawler_parser/models/video"
require "crawler_parser/loader"

require "crawler_parser/strategies/common"
require "crawler_parser/strategies/twitter"
require "crawler_parser/strategies/facebook"
require "crawler_parser/strategies/youtube"
require "crawler_parser/strategies/pinterest"

require "crawler_parser/parser"
require "crawler_parser/cli"

module CrawlerParser
  $logger = Logger.new(STDOUT)
  $logger.level = Logger::WARN
end
