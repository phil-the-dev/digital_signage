class Kiosk < ApplicationRecord
  has_one :user_kiosk
  has_one :user, through: :user_kiosk
  
  def initialize args
    super(args)
    self.code = (0...4).map { (65 + rand(26)).chr }.join
  end

  def playable
    Playable.parse(playable_id)
  end
end
