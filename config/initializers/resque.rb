require 'resque'
require 'resque-scheduler'
require 'resque/scheduler/server'

redis_config = YAML.load_file(Rails.root.join '/config/redis.yml')
Resque.redis = "#{redis_config[Rails.env]['host']}:#{redis_config[Rails.env]['port']}"
