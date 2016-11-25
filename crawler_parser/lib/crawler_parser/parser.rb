module CrawlerParser
  class Parser
    def initialize(post)
      @post = post
    end

    def run
      card = ('CrawlerParser::' + @post.social_media.camelize).split('::').inject(Object) {|o,c| o.const_get c}.new(@post)
      
      card.run
    end
  end
end
