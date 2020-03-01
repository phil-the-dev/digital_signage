class Segment < ApplicationRecord
  include Playable

  has_many :episodes, through: :episode_segments
  has_one_attached :video

  def resolve
    { id: id, file: Rails.application.routes.url_helpers.url_for(video) }
  end
end
