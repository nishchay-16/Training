Sidekiq.configure_server do |config|
  config.average_scheduled_poll_interval = 15
  config.options[:concurrency] = 50
end

