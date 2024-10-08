require 'twitter'

class SocialMediaPostJob
  include Sidekiq::Job
  sidekiq_options queue: 'default'

  def perform(platform, message, options = {})
    case platform
    when 'twitter'
      post_to_twitter(message, options)
    end
  end

  private

  def post_to_twitter(message, options)
    require 'twitter'
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end

    client.update(message)
  end
end
