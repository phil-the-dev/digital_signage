class Episode < ApplicationRecord
  include Playable
  has_many :segments, through: :episode_segments
  belongs_to :show

  def resolve
  end
end
