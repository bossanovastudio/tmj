class Card < ActiveResource::Base
  self.site = ENV['API_URL'] . "/api/cards"
end
