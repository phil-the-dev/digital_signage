class KioskController < ApplicationController
  before_action :setup_kiosk

  def play
  end

  def index
    @kiosk = Kiosk.create!
  end

  def show
    @kiosk = Kiosk.find(params[:id])
    # @videos = @kiosk.playable.episodes.map{ |ep| ep.resolve.map { |segment| { id: segment.id, file: url_for(segment.video) } } }.flatten ? 
    @videos = @kiosk.playable.resolve
    render layout: "kiosk"
  end

  private 

  def setup_kiosk
    @playable = Struct.new(:videos) do
      def load_videos collection
        self.videos = collection
      end
    end
  end
end