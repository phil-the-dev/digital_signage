class Playlist < ApplicationRecord
  include Playable

  has_many :playlist_playables
  has_many :playables, through: :playlist_playables

  def resolve
    self.ordered_playables.map { |playable| playable.resolve }.flatten
  end

  def ordered_playables
    self.playlist_playables.order(:order)
  end
end
