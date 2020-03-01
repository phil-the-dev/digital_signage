  class Kiosk::ShowsController < KioskController
    def play
      @videos = show.resolve
    end

    private
    def show
      @show ||= Show.find(params[:id])
    end
  end