$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
Dotenv.load '../env/.env'

require 'crawler_socialnetwork'
require 'minitest/autorun'
