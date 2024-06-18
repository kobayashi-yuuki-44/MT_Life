require 'sidekiq'
require 'sidekiq-cron'

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'], network_timeout: 5, reconnect_attempts: 1 }

  schedule_file = "config/sidekiq.yml"

  if File.exist?(schedule_file)
    schedule = YAML.load_file(schedule_file)["schedule"]
    if schedule
      Sidekiq::Cron::Job.load_from_hash(schedule)
    end
  end
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'], network_timeout: 5, reconnect_attempts: 1 }
end