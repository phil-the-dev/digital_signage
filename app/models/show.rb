class Show < ApplicationRecord
  include Playable
  has_many :episodes
end
