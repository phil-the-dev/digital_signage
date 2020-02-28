class PagesController < ApplicationController
  def index
  end

  def link
    @user_kiosk = UserKiosk.new
  end

  def link_kiosk
    @user_kiosk = UserKiosk.new
    @user_kiosk.user = User.first
    @user_kiosk.kiosk = Kiosk.where(code: params.dig("user_kiosk", "code")).first
    @user_kiosk.kiosk.name = params[:name]

    respond_to do |format|
      if @user_kiosk.save
        format.html { redirect_to @user_kiosk.kiosk, notice: 'Kiosk link was successfully created.' }
        format.json { render :show, status: :created, location: @user_kiosk.kiosk }
      else
        format.html { render :new }
        format.json { render json: @user_kiosk.errors, status: :unprocessable_entity }
      end
    end
  end

  def kiosks
    @kiosks = Kiosk.all
  end
end
