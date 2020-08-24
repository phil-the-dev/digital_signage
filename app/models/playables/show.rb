class Show < ApplicationRecord
  include Playable
  has_many :episodes

  def resolve
    self.episodes.map { |episode| episode.resolve }.flatten
  end
end
