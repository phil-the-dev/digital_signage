class Segment < ApplicationRecord
  has_many :episodes, through: :episode_segments
  has_one_attached :video
end
