class PlayableController < ApplicationController
  layout "playable"
  before_action :setup_playable

  def play
  end

  private 

  def setup_playable
    @playable = Struct.new(:videos) do
      def load_videos collection
        self.videos = collection
      end
    end
    puts "herheehrherhehrherheh"
  end
end