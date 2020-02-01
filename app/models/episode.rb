class Episode < ApplicationRecord
  has_many :segments, through: :episode_segments
end
