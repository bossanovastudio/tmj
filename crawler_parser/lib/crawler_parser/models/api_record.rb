class ApiRecord < ActiveRecord::Base
  self.abstract_class = true

  ActiveRecord::Base.establish_connection(
    adapter:  'postgresql',
    encoding: 'unicode',
    database: ENV['RDS_DB_NAME'],
    username: ENV['RDS_USERNAME'],
    password: ENV['RDS_PASSWORD'],
    host:     ENV['RDS_HOSTNAME'],
    port:     ENV['RDS_PORT']
  )
end
