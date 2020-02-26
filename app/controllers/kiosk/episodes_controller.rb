module Kiosk
  class EpisodesController < KioskController
    def play
      @videos = episode.resolve.map { |segment| { id: segment.id, file: url_for(segment.video) } }
    end

    private
    def episode
      @episode ||= Episode.find(params[:id])
    end
  end
end