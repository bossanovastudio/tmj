# Redis configu
Resque.redis = Redis.new

# Resque & ActiveRecord Connection Stablishment
Resque.after_fork = Proc.new { ActiveRecord::Base.establish_connection }
