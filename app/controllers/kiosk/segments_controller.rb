class Kiosk::SegmentsController < KioskController
  def play
    @videos = segment.resolve
  end

  private
  def segment
    @segment ||= Segment.find(params[:id])
end