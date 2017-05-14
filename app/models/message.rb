class Message < ApplicationRecord
  
  def self.new_from_fb(message)
    attributes = {
      fb_id:        message.id,
      sender:       message.sender['id'],
      seq:          message.seq,
      sent_at:      message.sent_at,
      text:         message.text,
    }
    unless message.attachments.nil? or message.attachments.empty?
      attachment = attachments.first
      attributes[:fb_audio_url] = attachment["url"] if attachment["type"] == "audio"
    end

    self.new(attributes)
  end
end
