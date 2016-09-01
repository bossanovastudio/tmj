class CrawledPost < CrawlerRecord
  enum social_media: { facebook: 1, twitter: 2 }
end
