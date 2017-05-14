include Facebook::Messenger

module Voxanon
  module FB
    class Bot
      def respond_to_user(message)
        response = if message.attachments and not message.attachments.any?{ |thing| thing["type"] == "audio" }
          #message = Message.new_from_fb(message)
          if true # message.valid?
            #message.save
            # post the audio file to Robert
          
            url = "https://process.text.audio/process"
            begin
              Rails.logger.info("Posting message (#{message.id}) to #{url}")
              HTTParty.post(url, {fb_id: message.id, fb_audio_url: attachments.first["url"]})
            end
            
            # tell the user that we'll send them a message after we've munged the audio
            { text: "Thanks! Let us process this for a second..." }
          else
            Rails.warn("Something went wrong saving #{message.inspect}.")
            # something went wrong from facebook?
          end
        else
          # tell the user how to send audio
          { 
            text: <<-MESSAGE
Hi from VoxAnon! Here’s how you can share your story with the world. 

If you are ready to share right now, press and hold the record button - hold the phone 6 inches from your mouth, speak clearly, not too loudly, not too softly.
MESSAGE
          }
        end
        #message.reply(text: 'Hello, human!')
        message.reply(response)
      end
      
      def tell_user_their_audio_is_ready(message)
        message.sender
      end
    end
  end
end

Bot.on :message do |message|
  bot = Voxanon::FB::Bot.new
  
  bot.respond_to_user(message)
  
  Rails.logger.info "\n==================================="
  Rails.logger.info message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
  Rails.logger.info message.sender      # => { 'id' => '1008372609250235' }
  Rails.logger.info message.seq         # => 73
  Rails.logger.info message.sent_at     # => 2016-04-22 21:30:36 +0200
  Rails.logger.info message.text        # => 'Hello, bot!'
  Rails.logger.info message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
  Rails.logger.info "\n===================================\n"
end

=begin

Bot.on :message do |message|
  Voxanon::Bot.respond_to(message)
end

Bot.deliver({recipient: {id: 1294826150634181},message:{ attachment:{type:"audio", payload: {url:"http://rmozone.com/snapshots/2017/03/ums.mp3"}}}}, access_token: ENV['ACCESS_TOKEN'])

User can record audio
=> Audio gets munged
=> Bot can notify user
=> User can ask for filtered version
=> Bot will message back filtered audio
=> Bot will ask user if message can be published.

Message:
  public: Boolean
  filter: String
  FB_audio_id: String

=end