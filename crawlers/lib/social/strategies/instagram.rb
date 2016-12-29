require 'httparty'
require 'json'

module Crawlers::Social
  class Instagram
    include HTTParty
    base_uri 'www.instagram.com'
    headers "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0) Gecko/20100101 Firefox/52.0"

    def profile(u)
      puts "Instagram#profile for #{u}"
      begin
        process_json_result(JSON.parse(self.class.get("/#{u}/media").body)['items'])
      rescue Exception => ex
        $logger.error("Error acquiring Instagram data for profile with ID #{u}: #{ex}")
      end
    end

    def hashtag(tag)
      puts "Instagram#hashtag for #{tag}"
      begin
        data = JSON.parse(self.class.get("/explore/tags/#{tag}", { query: { __a: 1 } }).body)
        data = (data['tag']['media']['nodes'] + data['tag']['top_posts']['nodes'])
          .collect { |p| p['code'] }
          .collect { |code| JSON.parse(self.class.get("/p/#{code}", { query: { __a: 1 } }).body)['media'] }
        process_json_result(data)
      rescue Exception => ex
        $logger.error("Error acquiring Instagram data for hashtag #{tag}: #{ex}")
      end
    end

    def process_json_result(data)
      begin
        data
          .select { |node| !node['is_video'] }
          .each do |node|
            next if CrawledPost.find_by_social_uuid(node['code'])
            post = CrawledPost.new(
              social_media: :instagram,
              social_uuid: node['code'],
              data: node
            )
            $logger.error("Error saving post: #{post.inspect}") unless post.save
          end
      rescue Exception => ex
        $logger.error("Error processing JSON payload for Instagram data: #{ex}")
      end
    end
  end
end
