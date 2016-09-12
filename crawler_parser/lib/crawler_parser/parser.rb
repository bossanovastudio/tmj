module CrawlerParser
  class Parser
    def initialize(post)
      @post = post
    end

    def run
      card = self.send(@post.social_media, @post)

      unless card.save
        $logger.error('Error saving card: #{card.inspect}')
      end
    end

    private
    def facebook(post)
      card = Card.new
      card.origin     = 1
      card.content    = post.content.message
      card.posted_at  = post.content.created_time

      card
    end

    def twitter(post)
      card = Card.new
      card.origin     = 2
      card.content    = post.content.text
      card.posted_at  = post.content.created_at

      card
    end
  end
end
