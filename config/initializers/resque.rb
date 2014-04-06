require 'resque'
require 'resque-scheduler'

redis_config = YAML.load_file(File.join(Rails.root, '/config/redis.yml'))
Resque.redis = "#{redis_config[Rails.env]['host']}:#{redis_config[Rails.env]['port']}"
Resque::Scheduler.dynamic = true
Resque.schedule =
  if Rails.env.test?
    Resque.inline = true
    {}
  else
    schedules = YAML.load_file(File.join(Rails.root, '/config/resque_schedule.yml'))
    Hash(schedules[Rails.env])
  end
