module CrawlerParser
  class CLI
    def initialize
      @loader = Loader.new
    end

    def run
      begin
        @loader.each do |crawled_post|
          parser = Parser.new(crawled_post)
          parser.run
        end
      rescue => e
        $logger.error(e)
      end
    end
  end
end
