module Playable
  class EpisodesController < PlayableController
    def play
      @playable = "episode"
    end
  end
end