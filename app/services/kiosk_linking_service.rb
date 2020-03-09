class KioskLinkingService
  class << self
    def perform(kiosk, user)
      new(kiosk, user).perform
    end 
  end

  def initialize(kiosk, user)
    @kiosk = kiosk
    @user = user
  end

  def perform
    user_kiosk = UserKiosk.new(user: @user, kiosk: @kiosk, auth_token: SecureRandom.base58(24))

    @kiosk.playable_id = Show.first.playable_id # TODO: should be dynamic
    @kiosk.save
  end
end