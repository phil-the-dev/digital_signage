class EpisodeSegment < ApplicationRecord
  belongs_to :episode
  belongs_to :segment
end
