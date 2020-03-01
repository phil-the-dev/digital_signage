class UserKioskChannel < ApplicationCable::Channel
  def subscribed
    stream_for Kiosk.where(code: params[:kiosk_code]).first
  end
  
  def unsubscribed
  end
  
  def complete_link(data)
    puts "were here"
    session[:kiosk] = data[:token]
  end
end