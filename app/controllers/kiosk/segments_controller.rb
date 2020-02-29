class Kiosk::SegmentsController < KioskController
  def play
    @videos = [{ id: Segment.first.id, file: url_for(Segment.first.video) }]
  end
end