module Admin
  class SegmentsController < ApplicationController
    before_action :set_segment, only: [:show, :edit, :update, :destroy]

    # GET /segments
    # GET /segments.json
    def index
      @segments = Segment.all
    end

    # GET /segments/1
    # GET /segments/1.json
    def show
    end

    # GET /segments/new
    def new
      @segment = Segment.new
    end

    # GET /segments/1/edit
    def edit
    end

    # POST /segments
    # POST /segments.json
    def create
      @segment = Segment.new(segment_params)
      @segment.video.attach(params[:segment][:video])

      respond_to do |format|
        if @segment.save
          format.html { redirect_to [:admin, @segment], notice: 'Segment was successfully created.' }
          format.json { render :show, status: :created, location: @segment }
        else
          format.html { render :new }
          format.json { render json: @segment.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /segments/1
    # PATCH/PUT /segments/1.json
    def update
      respond_to do |format| 
      if @segment.update(segment_params) && @segment.video.attach(params[:segment][:video])
          format.html { redirect_to [:admin, @segment], notice: 'Segment was successfully updated.' }
          format.json { render :show, status: :ok, location: @segment }
        else
          format.html { render :edit }
          format.json { render json: @segment.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /segments/1
    # DELETE /segments/1.json
    def destroy
      @segment.destroy
      respond_to do |format|
        format.html { redirect_to segment_url, notice: 'Segment was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_segment
        @segment = Segment.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def segment_params
        params.require(:segment).permit(:title)
      end
  end
end