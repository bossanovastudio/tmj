CarrierWave.configure do |config|
  config.ignore_integrity_errors = false
  config.ignore_processing_errors = false
  config.ignore_download_errors = false

  config.asset_host = ENV['ASSETS_URL']
  config.fog_provider = 'fog/aws'
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
    aws_secret_access_key: ENV['AWS_SECRET_KEY'],
    region:                'sa-east-1'
  }

  config.fog_directory = ENV['AWS_S3_ASSETS_BUCKET']
  config.fog_public = true
end