class KioskController < ApplicationController
  before_action :setup_kiosk

  def play
  end

  def index
    @kiosk = Kiosk.create!
  end

  def show
    @videos = Kiosk.find(params[:id]).playable.resolve
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