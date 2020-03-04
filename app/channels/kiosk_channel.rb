class KioskChannel < ApplicationCable::Channel
  def subscribed
    stream_for kiosk
  end
  
  def unsubscribed
  end
  
  def play(data)
    KioskChannel.broadcast_to kiosk, data
  end

  def pause(data)
    KioskChannel.broadcast_to kiosk, data
  end

  private
  def kiosk
    Kiosk.find(params[:kiosk_id])
  end
end