class Video < ActiveResource::Base
  self.site = ENV['API_URL']
end
