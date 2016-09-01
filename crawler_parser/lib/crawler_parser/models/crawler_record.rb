class CrawlerRecord < ActiveRecord::Base
  self.abstract_class = true

  ActiveRecord::Base.establish_connection(
    adapter:  'postgresql',
    encoding: 'unicode',
    database: ENV['CRAWLER_RDS_DB_NAME'],
    username: ENV['CRAWLER_RDS_USERNAME'],
    password: ENV['CRAWLER_RDS_PASSWORD'],
    host:     ENV['CRAWLER_RDS_HOSTNAME'],
    port:     ENV['CRAWLER_RDS_PORT']
  )
end
