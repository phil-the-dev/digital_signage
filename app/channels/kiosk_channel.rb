class KioskChannel < ApplicationCable::Channel
  def subscribed
    stream_for Kiosk.find(params[:kiosk_id])
  end
  
  def unsubscribed
  end
  
  def play(data)
    KioskChannel.broadcast_to Kiosk.first, data
  end

  def pause(data)
    KioskChannel.broadcast_to Kiosk.first, data
  end
end