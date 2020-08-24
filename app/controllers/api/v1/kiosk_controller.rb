# frozen_string_literal: true

module Api
  module V1
    class KioskController < ApiController
      def new
        kiosk = Kiosk.create!
        render json: { kiosk: { code: kiosk.code, id: kiosk.id } }
      end
      
      def videos
        kiosk = Kiosk.find(params[:id])
        videos = kiosk.playable.resolve
        render json: { videos: videos }
      end
    end
  end
end
