class CrawledPost < CrawlerRecord
  enum social_media: { facebook: 1, twitter: 2 }

  def content
    OpenStruct.new self.data
  end
end
