require "logger"
require "ostruct"

require "active_record"
require "active_resource"
require "koala"
require "twitter"
require "google/api_client"
require "active_record"
require "pinterest-api"
require "httparty"
require "tumblr_client"

module Crawlers
  $logger = Logger.new(STDOUT)
  $logger.level = Logger::WARN
end


require_relative "models/application_record"
require_relative "models/crawled_post"
require_relative "models/card"
require_relative "models/image"
require_relative "models/video"
require_relative "models/remix_user_image"

require_relative "./parser/loader"
require_relative "./parser/strategies/common"
require_relative "./parser/strategies/twitter"
require_relative "./parser/strategies/facebook"
require_relative "./parser/strategies/youtube"
require_relative "./parser/strategies/pinterest"
require_relative "./parser/strategies/tumblr"
require_relative "./parser/strategies/instagram"
require_relative "./parser/parser"
require_relative "./parser/cli"

require_relative "./social/strategies/facebook"
require_relative "./social/strategies/twitter"
require_relative "./social/strategies/youtube"
require_relative "./social/strategies/pinterest"
require_relative "./social/strategies/instagram"
require_relative "./social/strategies/tumblr"
require_relative "./social/cli"

