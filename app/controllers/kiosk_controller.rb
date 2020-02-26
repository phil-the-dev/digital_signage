class KioskController < ApplicationController
  layout :choose_layout
  before_action :setup_kiosk

  def play
  end

  def index
  end

  private 

  def choose_layout
    params["action"] == "index" ? "application" : "kiosk"
  end

  def setup_kiosk
    @playable = Struct.new(:videos) do
      def load_videos collection
        self.videos = collection
      end
    end
  end
end