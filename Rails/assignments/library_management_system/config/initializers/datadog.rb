Datadog.configure do |c|
  # Tracing setup for Rails
  c.tracing.instrument :rails

  # Optional: Enable additional instrumentation
  c.tracing.instrument :http
  c.tracing.instrument :redis
  c.tracing.instrument :sidekiq

  # Optional: Set service name, environment, and version
  c.service = 'my-rails-app'
  c.env = 'development'
  c.version = '1.0.0'

  c.api_key = ENV['DATADOG_API_KEY']

end
