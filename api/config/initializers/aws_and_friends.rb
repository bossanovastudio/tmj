require 'aws-sdk'

Aws.config.update({
  region: 'sa-east-1',
  credentials: Aws::Credentials.new(ENV['AWS_ACCESS_KEY_ID'], ENV['AWS_SECRET_KEY']),
})
