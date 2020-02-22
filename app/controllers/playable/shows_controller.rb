module Playable
  class ShowsController < PlayableController
    def play
      @playable = "show"
    end
  end
end