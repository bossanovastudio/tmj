require "logger"

require "active_record"
require "active_resource"

require "crawler_parser/version"
require "crawler_parser/models/crawled_record"
require "crawler_parser/models/crawled_post"
require "crawler_parser/models/card"
require "crawler_parser/cli"

module CrawlerParser
  $logger = Logger.new(STDOUT)
  $logger.level = Logger::WARN
end
