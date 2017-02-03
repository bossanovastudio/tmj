module Crawlers::Social
  class Facebook
    def initialize
      tokens = {}
      tokens[:facebook_app_id]     = ENV.fetch 'FACEBOOK_APP_ID'
      tokens[:facebook_app_secret] = ENV.fetch 'FACEBOOK_APP_SECRET'

      conn = Koala::Facebook::OAuth.new(tokens[:facebook_app_id], tokens[:facebook_app_secret])
      @graph = Koala::Facebook::API.new(conn.get_app_access_token, tokens[:facebook_app_secret])
    end

    def timeline(user_id=nil, query_words=[])
      raise RuntimeError unless user_id
      puts "Facebook#timeline for #{user_id}"
      begin
        feed = @graph.get_connections(user_id, "feed")
      rescue Exception => e
        $logger.error("Error processing feed #{user_id}: #{e}")
        return
      end

      feed.each do |post|
        begin
          unless CrawledPost.find_by_social_uuid(post['id'])
            post['user']        = @graph.get_object("/#{post['id']}?fields=from")
            post['attachments'] = @graph.get_object("/#{post['id']}/attachments")

            crawled_post = CrawledPost.new
            crawled_post.social_media = :facebook
            crawled_post.social_uuid  = post['id']
            crawled_post.data = post
            
            if query_words.any?
              unless Regexp.union(query_words) =~ post.fetch('message', '')
                next
              end
            end
            
            unless crawled_post.save
              $logger.error("Error saving post: #{post.inspect}")
            end
          end
        rescue Exception => e
          $logger.error("Error processing post: #{post.inspect} -> #{e}")
        end
      end
    end
  end
end
