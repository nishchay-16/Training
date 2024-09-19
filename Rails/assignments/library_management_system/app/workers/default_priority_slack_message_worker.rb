class DefaultPrioritySlackMessageWorker
  include Sidekiq::Worker
  sidekiq_options queue: 'default'

  def perform(message, channel = '#general')
    send_message(message, channel)
  end

  private

  def send_message(message, channel)
    uri = URI(ENV['SLACK_WEBHOOK_URL'])
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == 'https')

    request = Net::HTTP::Post.new(uri.path, {'Content-Type' => 'application/json'})
    request.body = { text: message, channel: channel }.to_json

    begin
      response = http.request(request)

      if response.is_a?(Net::HTTPSuccess)
        Rails.logger.info "Message sent successfully: #{response.body}"
      else
        Rails.logger.error "Failed to send message: #{response.body}"
      end
    rescue Errno::ECONNRESET => e
      Rails.logger.error "Connection reset error: #{e.message}"
    rescue => e
      Rails.logger.error "An error occurred: #{e.message}"
    end
  end
end
