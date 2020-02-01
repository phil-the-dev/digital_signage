class Segment < ApplicationRecord
  has_many :episodes, through: :episode_segments
end
