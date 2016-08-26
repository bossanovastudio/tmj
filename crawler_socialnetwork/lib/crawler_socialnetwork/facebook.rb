module CrawlerSocialnetwork
  class Facebook
    def initialize
      tokens = {}
      tokens[:facebook_app_id]     = ENV.fetch 'FACEBOOK_APP_ID'
      tokens[:facebook_app_secret] = ENV.fetch 'FACEBOOK_APP_SECRET'

      conn = Koala::Facebook::OAuth.new(tokens[:facebook_app_id], tokens[:facebook_app_secret])
      @graph = Koala::Facebook::API.new(conn.get_app_access_token)
    end

    def timeline
      timeline = @graph.get_object("/#{client.atsv012facebookn}/feed")

      timeline.each do |post|
        post[:attachments] = @graph.get_object("/#{post['id']}/attachments")

        post
      end
    end
  end
end
