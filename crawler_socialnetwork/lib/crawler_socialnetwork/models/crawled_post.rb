class CrawledPost < ApplicationRecord
  enum social_media: { facebook: 1, twitter: 2, youtube: 3, vimeo: 4, instagram: 5, pinterest: 6 }
end
