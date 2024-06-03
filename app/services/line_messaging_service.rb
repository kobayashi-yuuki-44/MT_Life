require 'line/bot'

class LineMessagingService
  def initialize
    @client = Line::Bot::Client.new do |config|
      config.channel_id = Rails.application.credentials.dig(:line, :messaging_channel_id)
      config.channel_secret = Rails.application.credentials.dig(:line, :messaging_channel_secret)
      config.channel_token = Rails.application.credentials.dig(:line, :messaging_channel_token)
    end
  end

  def push_message(user_id, message)
    message_payload = {
      type: 'text',
      text: message
    }
    response = @client.push_message(user_id, [message_payload])
  end
end