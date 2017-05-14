include Facebook::Messenger

Bot.on :message do |message|
  Rails.logger.info "\n==================================="
  Rails.logger.info message.id          # => 'mid.1457764197618:41d102a3e1ae206a38'
  Rails.logger.info message.sender      # => { 'id' => '1008372609250235' }
  Rails.logger.info message.seq         # => 73
  Rails.logger.info message.sent_at     # => 2016-04-22 21:30:36 +0200
  Rails.logger.info message.text        # => 'Hello, bot!'
  Rails.logger.info message.attachments # => [ { 'type' => 'image', 'payload' => { 'url' => 'https://www.example.com/1.jpg' } } ]
  Rails.logger.info "\n===================================\n"
  
  
  message.reply(text: 'Hello, human!')
end

=begin
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