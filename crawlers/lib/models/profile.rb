class Profile < ActiveResource::Base
  self.site = ENV['API_URL']
end
