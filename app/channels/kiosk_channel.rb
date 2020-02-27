class KioskChannel < ApplicationCable::Channel
  def subscribed
    # current_user.appear
  end
 
  def unsubscribed
    # current_user.disappear
  end
 
  def playing(data)
    # current_user.appear(on: data['appearing_on'])
    puts "IT'S PLAYING"
  end

  def paused(data)
    puts "IT'S PAUSED"
  end
end