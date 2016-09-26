# Redis configu
Resque.redis = ENV.fetch('REDIS_URL')

# Resque & ActiveRecord Connection Stablishment
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
