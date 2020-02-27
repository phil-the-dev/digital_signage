class KioskController < ApplicationController
  layout :choose_layout
  before_action :setup_kiosk

  def play
  end

  def index
    @kiosk = Kiosk.create!
  end

  def show
    @kiosk = Kiosk.find(params[:id])
    redirect_to @kiosk.url if(@kiosk.url.present?)
  end

  private 

  def choose_layout
    params["action"] == "play" ? "kiosk" : "application"
  end

  def setup_kiosk
    @playable = Struct.new(:videos) do
      def load_videos collection
        self.videos = collection
      end
    end
  end
end