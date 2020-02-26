module Kiosk
  class SegmentsController < KioskController
    def play
      @videos = [Segment.first.video]
    end
  end
end