class KioskChannel < ApplicationCable::Channel
  def subscribed
    stream_for Kiosk.find(params[:room])
    puts "and now I'm streaming"
    #stream_from "kiosk_channel"
  #  playing(Kiosk.first )
    # current_user.appear
  end
  
  def unsubscribed
    # current_user.disappear
  end
  
  def playing(data)
    # current_user.appear(on: data['appearing_on'])
    puts "IT'S PLAYING #{data}"
  end

  def paused(data)
    puts "IT'S PAUSED #{data}"
  end
end