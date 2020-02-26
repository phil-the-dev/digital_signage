class Kiosk::SegmentsController < KioskController
  def play
    @videos = [Segment.first.video]
  end
end