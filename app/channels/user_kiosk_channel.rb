class UserKioskChannel < ApplicationCable::Channel
  def subscribed
    stream_for Kiosk.where(code: params[:kiosk_code]).first
  end
  
  def unsubscribed
  end
end