require 'date'

module CrawlerParser
  class Instagram
    include Common

    def initialize(post)
      @post = post
    end

    def run
      if @post.data.fetch('display_src', nil).nil?
        card = parse_profile_node(@post.content)
      else
        card = parse_search_node(@post.content)
      end

      unless card.save
        $logger.error("Error saving card: #{card.inspect}")
      end
    end

    def parse_profile_node(data)
      card = Card.new
      card.origin = 'instagram'
      card.media_type = 'Image'
      card.media_id = self.image(data.images['standard_resolution']['url'])
      card.content = data.caption['text']
      card.source_url = data.link
      card.posted_at = DateTime.strptime(data.caption['created_time'].to_s,'%s')
      card.social_uid = data.caption['from']['id']

      card.social_user = {
              id: data.caption['from']['id'],
        username: data.caption['from']['username'],
      }
      return card
    end

    def parse_search_node(data)
      card = Card.new
      card.origin = 'instagram'
      card.media_type = 'Image'
      card.media_id = self.image(data.display_src)
      card.content = data.caption
      card.source_url = "https://www.instagram.com/p/#{data.code}"
      card.posted_at = DateTime.strptime(data.date.to_s, '%s')
      card.social_uid = data.owner['id']

      card.social_user = {
              id: data.owner['id'],
        username: data.owner['username'],
      }
      return card
    end
  end
end
