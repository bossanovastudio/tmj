require "logger"
require "ostruct"

require "active_record"
require "active_resource"

require "crawler_parser/version"
require "crawler_parser/models/crawler_record"
require "crawler_parser/models/crawled_post"
require "crawler_parser/models/card"
require "crawler_parser/loader"
require "crawler_parser/parser"
require "crawler_parser/cli"

module CrawlerParser
  $logger = Logger.new(STDOUT)
  $logger.level = Logger::WARN
end
