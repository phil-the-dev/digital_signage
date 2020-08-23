module Api
  module V1
    class KioskController < ApiController
      def videos
        kiosk = Kiosk.find(params[:id])
        videos = kiosk.playable.resolve
        render json: { videos: videos }
      end
    end
  end
end