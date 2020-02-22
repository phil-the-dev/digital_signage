module Playable
  class SegmentsController < PlayableController
    def play
      @videos = [Segment.first.video]
    end
  end
end