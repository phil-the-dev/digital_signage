class KioskController < ApplicationController
  layout "kiosk"
  before_action :setup_kiosk

  def play
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