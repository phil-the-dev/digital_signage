class PagesController < ApplicationController
  before_action :authenticate_auth_user!, only: [:link, :link_kiosk, :kiosks]

  def index
  end

  def link
    @user_kiosk = UserKiosk.new
  end

  def link_kiosk
    @user_kiosk = UserKiosk.new
    @user_kiosk.user = current_auth_user.user
    kiosk = Kiosk.where(code: params.dig("user_kiosk", "code")).first
    kiosk.name = params[:user_kiosk][:name]
    kiosk.playable_id = Show.first.playable_id
    kiosk.save!

    @user_kiosk.kiosk = kiosk
    @user_kiosk.save!
    respond_to do |format|
      if @user_kiosk.save
        UserKioskChannel.broadcast_to kiosk, { action: "link", kiosk_path: kiosk_path(kiosk) }
        format.html { redirect_to kiosks_path, notice: 'Kiosk link was successfully created.' }
        format.json { render :show, status: :created, location: @user_kiosk.kiosk }
      else
        format.html { render :new }
        format.json { render json: @user_kiosk.errors, status: :unprocessable_entity }
      end
    end
  end

  def kiosks
    @kiosks = current_auth_user.user.kiosks
  end
end
