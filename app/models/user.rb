class User < ApplicationRecord
  belongs_to :auth_user
  has_many :user_kiosks
  has_many :kiosks, through: :user_kiosks
end
