class MessagesController < ApplicationController
  
  def index
    render
  end
  
  def show
    render
  end
  
  def notify
    Rails.logger.info(params.inspect)
    message = Message.where(fb_id: params[:id]).first
    # return 404 unless message
  end
end
