module Playable
  class ShowsController < PlayableController
    def play
      @videos = show.episodes.map{ |ep| ep.resolve.map { |segment| { id: segment.id, file: url_for(segment.video) } } }.flatten 
    end

    private
    def show
      @show ||= Show.find(params[:id])
    end
  end
end