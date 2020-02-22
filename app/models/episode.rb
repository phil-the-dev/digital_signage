class Episode < ApplicationRecord
  include Playable
  has_many :episode_segments
  has_many :segments, through: :episode_segments
  belongs_to :show

  def resolve
    self.ordered_segments.with_attached_video
  end

  def ordered_segments
    self.segments.order(:order_number)
  end
end
