class UserKiosk < ApplicationRecord
  belongs_to :user
  belongs_to :kiosk

  def initialize args
    super(args)
    self.auth_token = SecureRandom.base58(24)
  end
end
