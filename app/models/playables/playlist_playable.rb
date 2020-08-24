class PlaylistPlayable < ApplicationRecord
  belongs_to :playlist

  def resolve
    self.playable.resolve
  end

  def playable
    Playable.parse(playable_id)
  end
end
