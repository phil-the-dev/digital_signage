class PlaylistPlayablesController < ApplicationController
  before_action :set_playlist_playable, only: [:show, :edit, :update, :destroy]

  # GET /playlist_playables
  # GET /playlist_playables.json
  def index
    @playlist_playables = PlaylistPlayable.all
  end

  # GET /playlist_playables/1
  # GET /playlist_playables/1.json
  def show
  end

  # GET /playlist_playables/new
  def new
    @playlist_playable = PlaylistPlayable.new
  end

  # GET /playlist_playables/1/edit
  def edit
  end

  # POST /playlist_playables
  # POST /playlist_playables.json
  def create
    @playlist_playable = PlaylistPlayable.new(playlist_playable_params)

    respond_to do |format|
      if @playlist_playable.save
        format.html { redirect_to @playlist_playable, notice: 'Playlist playable was successfully created.' }
        format.json { render :show, status: :created, location: @playlist_playable }
      else
        format.html { render :new }
        format.json { render json: @playlist_playable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /playlist_playables/1
  # PATCH/PUT /playlist_playables/1.json
  def update
    respond_to do |format|
      if @playlist_playable.update(playlist_playable_params)
        format.html { redirect_to @playlist_playable, notice: 'Playlist playable was successfully updated.' }
        format.json { render :show, status: :ok, location: @playlist_playable }
      else
        format.html { render :edit }
        format.json { render json: @playlist_playable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /playlist_playables/1
  # DELETE /playlist_playables/1.json
  def destroy
    @playlist_playable.destroy
    respond_to do |format|
      format.html { redirect_to playlist_playables_url, notice: 'Playlist playable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist_playable
      @playlist_playable = PlaylistPlayable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_playable_params
      params.require(:playlist_playable).permit(:playlist_id, :playable_id, :order)
    end
end
