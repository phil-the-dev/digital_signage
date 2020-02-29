class KioskChannel < ApplicationCable::Channel
  def subscribed
    stream_for Kiosk.find(params[:room])
  end
  
  def unsubscribed
  end
  
  def play(data)
    KioskChannel.broadcast_to Kiosk.first, data
  end

  def paused(data)
    KioskChannel.broadcast_to Kiosk.first, data
  end
end