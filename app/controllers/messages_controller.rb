class MessagesController < ApplicationController
  
  skip_before_action :verify_authenticity_token
  
  def index
    render
  end
  
  def show
    render
  end
  
  def notify
    Rails.logger.info(params.inspect)
    
    bot = Voxanon::FB::Bot.new
    params[:filters].each do |name, url|
      bot.tell_user_their_audio_is_ready({user_id: params[:sender_id], url: url})
    end
    # return 404 unless message
  end
end
