class UserKiosk < ApplicationRecord
  belongs_to :user
  belongs_to :kiosks
end
