module Playable
  class EpisodesController < PlayableController
    def play
      @videos = episode.resolve.map{|ep| ep.video}
    end

    private
    def episode
      @episode ||= Episode.find(params[:id])
    end
  end
end