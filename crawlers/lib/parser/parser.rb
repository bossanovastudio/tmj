module Crawlers::Parser
  class Parser
    def initialize(post)
      @post = post
    end

    def run
      card = ('Crawlers::Parser::' + @post.social_media.camelize).split('::').inject(Object) {|o,c| o.const_get c}.new(@post)
      begin 
        card.run
        @post.update_attributes({ parsed: true, parsed_at: Time.now })
      rescue Exception => e
        $logger.error(e)
      end
    end
  end
end
